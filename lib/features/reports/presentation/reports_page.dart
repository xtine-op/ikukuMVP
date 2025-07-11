import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import 'farm_report_entry_page.dart';
import 'report_detail_page.dart';

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
    // Fallback: fetch daily records if get_monthly_farm_summary is missing
    try {
      final data = await SupabaseService().fetchReports(user.id);
      setState(() {
        reports = data;
        loading = false;
      });
    } catch (e) {
      // If the RPC fails, fallback to daily records
      final data = await SupabaseService().fetchDailyRecords(user.id);
      setState(() {
        reports = data;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? const BackButton() : null,
        title: const Text('My Farm Reports'),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: CustomColors.buttonGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.add, color: CustomColors.text),
                        label: Text(
                          'Add Farm Report',
                          style: TextStyle(color: CustomColors.text),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const FarmReportEntryPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          foregroundColor: CustomColors.text,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // TEXT "PREVIOUS REPORTS"
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Previous Reports',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // List of previous reports
                Expanded(
                  child: ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, i) {
                      final report = reports[i];
                      return ListTile(
                        title: Text(report['batch_name'] ?? 'Batch'),
                        subtitle: Text(
                          '${report['date'] ?? ''} • ${report['batch_type'] ?? ''}',
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ReportDetailPage(report: report),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
