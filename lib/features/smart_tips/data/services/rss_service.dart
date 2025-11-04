import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';
import '../models/news_article.dart';

class RssService {
  static const String _cacheKey = 'cached_news_articles';
  final List<String> _rssFeedUrls = [
    'https://www.thepoultrysite.com/feed',
    'https://www.poultrynews.co.uk/feed/',
    'https://www.wattagnet.com/rss/topic/193-layers',
  ];

  Future<List<NewsArticle>> fetchLatestNews() async {
    final List<NewsArticle> allArticles = [];

    for (final url in _rssFeedUrls) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final document = XmlDocument.parse(response.body);
          final items = document.findAllElements('item');

          for (final item in items) {
            final articleData = <String, dynamic>{
              'title': _getElementText(item, 'title'),
              'description': _cleanDescription(
                _getElementText(item, 'description'),
              ),
              'link': _getElementText(item, 'link'),
              'pubDate': _getElementText(item, 'pubDate'),
              'source': _getFeedName(url),
            };

            // Get image URL from media:content or enclosure
            final mediaContent = item.findElements('media:content').firstOrNull;
            final enclosure = item.findElements('enclosure').firstOrNull;

            if (mediaContent != null) {
              if (mediaContent.getAttribute('url') != null) {
                articleData['enclosure'] = {
                  'url': mediaContent.getAttribute('url')!,
                };
              }
            } else if (enclosure != null) {
              if (enclosure.getAttribute('url') != null) {
                articleData['enclosure'] = {
                  'url': enclosure.getAttribute('url')!,
                };
              }
            }

            allArticles.add(NewsArticle.fromRss(articleData));
          }
        }
      } catch (e) {
        print('Error fetching RSS feed from \$url: \$e');
      }
    }

    allArticles.sort((a, b) => b.publishDate.compareTo(a.publishDate));

    // Cache the latest articles
    _cacheArticles(allArticles);

    return allArticles;
  }

  Future<List<NewsArticle>> getCachedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(_cacheKey);

    if (cachedData != null) {
      final List<dynamic> decodedData = json.decode(cachedData);
      return decodedData.map((item) => NewsArticle.fromJson(item)).toList();
    }

    return [];
  }

  Future<void> _cacheArticles(List<NewsArticle> articles) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(
      articles.map((article) => article.toJson()).toList(),
    );
    await prefs.setString(_cacheKey, encodedData);
  }

  String _getElementText(XmlElement item, String elementName) {
    final element = item.findElements(elementName).firstOrNull;
    return element?.text ?? '';
  }

  String _cleanDescription(String description) {
    // Remove HTML tags
    description = description.replaceAll(RegExp(r'<[^>]*>'), '');
    // Decode HTML entities
    description = description
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");
    return description.trim();
  }

  String _getFeedName(String url) {
    if (url.contains('thepoultrysite')) return 'The Poultry Site';
    if (url.contains('poultrynews.co.uk')) return 'Poultry News UK';
    if (url.contains('wattagnet')) return 'WattAgNet';
    return 'Poultry News';
  }
}
