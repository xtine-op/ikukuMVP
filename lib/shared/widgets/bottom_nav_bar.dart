import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          // Home: Go to dashboard
          context.go('/');
        } else if (index == 2) {
          // Profile: Go to profile page
          context.go('/profile');
        } else {
          // My Shop: Show inactive message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('This feature is coming soon!'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'.tr()),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'my_shop'.tr()),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'.tr()),
      ],
      selectedItemColor: CustomColors.primary,
      unselectedItemColor: Colors.black45,
    );
  }
}
