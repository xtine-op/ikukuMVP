import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/services/supabase_service.dart';
import 'farm_report_entry_page.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Map<String, dynamic>> reports = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    final data = await SupabaseService().fetchReports(user.id);
    setState(() {
      reports = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? const BackButton() : null,
        title: const Text('View Farm Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Farm Report',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FarmReportEntryPage()),
              );
            },
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, i) {
                final report = reports[i];
                return ListTile(
                  title: Text('Date: ${report['date'] ?? ''}'),
                  subtitle: Text(
                    'Chickens: ${report['total_chickens'] ?? 0}, Deaths: ${report['total_deaths'] ?? 0}, Batches: ${report['total_batches'] ?? 0}',
                  ),
                );
              },
            ),
    );
  }
}
