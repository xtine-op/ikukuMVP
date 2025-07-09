import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/feature_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? const BackButton() : null,
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TODO: Add summary widgets for total chickens, deaths, batches
            const SizedBox(height: 24),
            FeatureButton(
              label: 'Batches',
              icon: Icons.list_alt,
              onTap: () => context.go('/batches'),
            ),
            FeatureButton(
              label: 'Farm Store',
              icon: Icons.store,
              onTap: () => context.go('/inventory'),
            ),
            FeatureButton(
              label: 'Daily Reports',
              icon: Icons.bar_chart,
              onTap: () => context.go('/reports'),
            ),
            FeatureButton(
              label: 'View Farm Reports',
              icon: Icons.assignment,
              onTap: () => context.go('/records'),
            ),
          ],
        ),
      ),
    );
  }
}
