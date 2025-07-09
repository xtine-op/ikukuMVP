import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/auth/presentation/sign_in_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/batches/presentation/batches_page.dart';
import '../features/inventory/presentation/inventory_page.dart';
import '../features/records/presentation/records_page.dart';
import '../features/reports/presentation/reports_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
      GoRoute(
        path: '/batches',
        builder: (context, state) => const BatchesPage(),
      ),
      GoRoute(
        path: '/inventory',
        builder: (context, state) => const InventoryPage(),
      ),
      GoRoute(
        path: '/records',
        builder: (context, state) => const RecordsPage(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsPage(),
      ),
    ],
    redirect: (context, state) {
      final user = Supabase.instance.client.auth.currentUser;
      final loggingIn = state.matchedLocation == '/sign-in';
      if (user == null && !loggingIn) return '/sign-in';
      if (user != null && loggingIn) return '/';
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(child: Text('404 - Page Not Found')),
    ),
  );
}
