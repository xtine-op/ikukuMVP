import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  int _selectedIndex = 0; // Set to a valid tab index

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/inventory');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      _CategoryCardData(
        label: tr('feeds'),
        iconPath: 'assets/icons/feeds.svg',
        subtitle: tr('feeds_available_inventory'),
        color: Colors.green.shade800,
        category: 'feed',
      ),
      _CategoryCardData(
        label: tr('vaccines'),
        iconPath: 'assets/icons/vaccines.svg',
        subtitle: tr('vaccines_available_inventory'),
        color: Colors.green.shade800,
        category: 'vaccine',
      ),
      _CategoryCardData(
        label: tr('others'),
        iconPath: 'assets/icons/others.svg',
        subtitle: tr('others_available_inventory'),
        color: Colors.green.shade800,
        category: 'other',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(
          tr('my_farm_store'),
          style: const TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            const SizedBox(height: 8),
            ...categories.map(
              (cat) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _CategoryCard(data: cat),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

class _CategoryCardData {
  final String label;
  final String iconPath;
  final String subtitle;
  final Color color;
  final String category;
  _CategoryCardData({
    required this.label,
    required this.iconPath,
    required this.subtitle,
    required this.color,
    required this.category,
  });
}

class _CategoryCard extends StatelessWidget {
  final _CategoryCardData data;
  const _CategoryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.go('/inventory-items/${data.category}');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: data.color, width: 1.2),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                data.iconPath,
                width: 36,
                height: 36,
                color: data.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
