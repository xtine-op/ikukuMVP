import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app_theme.dart';
import '../../../services/rss_service.dart';

class SmartTipsPage extends StatefulWidget {
  const SmartTipsPage({Key? key}) : super(key: key);

  @override
  State<SmartTipsPage> createState() => _SmartTipsPageState();
}

class _SmartTipsPageState extends State<SmartTipsPage> {
  String? _selectedBlog;
  List<_ExternalTip> _externalTips = [];

  @override
  void initState() {
    super.initState();
    _loadExternalTips();
  }

  Future<void> _openArticle(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }

  Future<void> _loadExternalTips() async {
    // Seed with known reputable African poultry resources
    final seeded = <_ExternalTip>[
      _ExternalTip(
        title: 'PoultryWorld Africa: Biosecurity Basics',
        source: 'Poultry World',
        url: Uri.parse(
          'https://www.poultryworld.net/health-nutrition/biosecurity/',
        ),
      ),
      _ExternalTip(
        title: 'ILRI: African Poultry Insights',
        source: 'ILRI',
        url: Uri.parse('https://www.ilri.org/tags/poultry'),
      ),
      _ExternalTip(
        title: 'CGIAR: Smallholder Poultry Resources',
        source: 'CGIAR',
        url: Uri.parse('https://www.cgiar.org/initiative/animal-source-foods/'),
      ),
    ];
    setState(() => _externalTips = seeded);
    // Placeholder for future live fetch from curated endpoints
    // try { final resp = await http.get(Uri.parse('https://example.com/africa-poultry-feed.json')); } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedBlog != null) {
      return _buildBlogDetail(context, _selectedBlog!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('smart_tips_title'.tr()),
        leading: Navigator.of(context).canPop() ? const BackButton() : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'educational_blog_title'.tr(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: CustomColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'educational_blog_subtitle'.tr(),
              style: TextStyle(
                color: CustomColors.text.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            _buildBlogCard(
              context,
              title: 'farm_records_blog_title'.tr(),
              summary: 'farm_records_blog_summary'.tr(),
              emoji: '🐔',
              blogId: 'farm_records',
            ),
            const SizedBox(height: 16),
            _buildBlogCard(
              context,
              title: 'disease_management_blog_title'.tr(),
              summary: 'disease_management_blog_summary'.tr(),
              emoji: '🧫',
              blogId: 'disease_management',
            ),
            const SizedBox(height: 32),
            Text(
              'Latest Poultry News',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: CustomColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Stay updated with the latest poultry farming news and insights',
              style: TextStyle(
                color: CustomColors.text.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<NewsArticle>>(
              future: RssService().fetchLatestNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No news articles available',
                        style: TextStyle(
                          color: CustomColors.text.withOpacity(0.7),
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: snapshot.data!.map((article) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article.imageUrl != null)
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                article.imageUrl!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${article.source} • ${DateFormat.yMMMd().format(article.publishDate)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CustomColors.text.withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  article.description,
                                  style: TextStyle(
                                    color: CustomColors.text.withOpacity(0.8),
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => _openArticle(article.link),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Read Full Article'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildBlogCard(
              context,
              title: 'housing_biosecurity_blog_title'.tr(),
              summary: 'housing_biosecurity_blog_summary'.tr(),
              emoji: '🏠',
              blogId: 'housing_biosecurity',
            ),
            const SizedBox(height: 16),
            _buildBlogCard(
              context,
              title: 'chicken_breed_blog_title'.tr(),
              summary: 'chicken_breed_blog_summary'.tr(),
              emoji: '🐣',
              blogId: 'chicken_breed',
            ),
            const SizedBox(height: 16),
            _buildBlogCard(
              context,
              title: 'climate_smart_blog_title'.tr(),
              summary: 'climate_smart_blog_summary'.tr(),
              emoji: '🌾',
              blogId: 'climate_smart',
            ),
            const SizedBox(height: 16),
            _buildBlogCard(
              context,
              title: 'finance_management_blog_title'.tr(),
              summary: 'finance_management_blog_summary'.tr(),
              emoji: '💰',
              blogId: 'finance_management',
            ),
            const SizedBox(height: 24),
            Text(
              'More tips from trusted African poultry sources',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ..._externalTips
                .map((t) => _buildExternalTipCard(context, t))
                .toList(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String emoji,
    required String blogId,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => setState(() => _selectedBlog = blogId),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.text,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                summary,
                style: TextStyle(
                  color: CustomColors.text.withOpacity(0.8),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => setState(() => _selectedBlog = blogId),
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: Text('read_more'.tr()),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogDetail(BuildContext context, String blogId) {
    final blogData = _getBlogData(blogId);

    return Scaffold(
      appBar: AppBar(
        title: Text(blogData['title'] ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _selectedBlog = null),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with emoji and title
            Row(
              children: [
                Text(
                  blogData['emoji'] ?? '',
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    blogData['title'] ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.text,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Text(
                blogData['summary'] ?? '',
                style: TextStyle(
                  color: CustomColors.text,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Full content (Markdown to support **bold** etc.)
            MarkdownBody(
              data: blogData['content'] ?? '',
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 15, height: 1.6),
              ),
              onTapLink: (text, href, title) async {
                if (href == null) return;
                final uri = Uri.parse(href);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
            const SizedBox(height: 32),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => setState(() => _selectedBlog = null),
                icon: const Icon(Icons.close),
                label: Text('close_blog'.tr()),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _getBlogData(String blogId) {
    switch (blogId) {
      case 'farm_records':
        return {
          'title': 'farm_records_blog_title'.tr(),
          'summary': 'farm_records_blog_summary'.tr(),
          'emoji': '🐔',
          'content': 'farm_records_blog_content'.tr(),
        };
      case 'disease_management':
        return {
          'title': 'disease_management_blog_title'.tr(),
          'summary': 'disease_management_blog_summary'.tr(),
          'emoji': '🧫',
          'content': 'disease_management_blog_content'.tr(),
        };
      case 'housing_biosecurity':
        return {
          'title': 'housing_biosecurity_blog_title'.tr(),
          'summary': 'housing_biosecurity_blog_summary'.tr(),
          'emoji': '🏠',
          'content': 'housing_biosecurity_blog_content'.tr(),
        };
      case 'chicken_breed':
        return {
          'title': 'chicken_breed_blog_title'.tr(),
          'summary': 'chicken_breed_blog_summary'.tr(),
          'emoji': '🐣',
          'content': 'chicken_breed_blog_content'.tr(),
        };
      case 'climate_smart':
        return {
          'title': 'climate_smart_blog_title'.tr(),
          'summary': 'climate_smart_blog_summary'.tr(),
          'emoji': '🌾',
          'content': 'climate_smart_blog_content'.tr(),
        };
      case 'finance_management':
        return {
          'title': 'finance_management_blog_title'.tr(),
          'summary': 'finance_management_blog_summary'.tr(),
          'emoji': '💰',
          'content': 'finance_management_blog_content'.tr(),
        };
      default:
        return {'title': '', 'summary': '', 'emoji': '', 'content': ''};
    }
  }
}

class _ExternalTip {
  final String title;
  final String source;
  final Uri url;
  _ExternalTip({required this.title, required this.source, required this.url});
}

Widget _buildExternalTipCard(BuildContext context, _ExternalTip tip) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      leading: const Icon(Icons.public),
      title: Text(tip.title),
      subtitle: Text(tip.source),
      trailing: const Icon(Icons.open_in_new),
      onTap: () async {
        if (await canLaunchUrl(tip.url)) {
          final launched = await launchUrl(
            tip.url,
            mode: LaunchMode.externalApplication,
          );
          if (!launched && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open link')),
            );
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No app found to open link')),
            );
          }
        }
      },
    ),
  );
}
