import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import '../../../shared/services/connectivity_manager.dart';
import '../../../shared/services/offline_service.dart';
import '../../../shared/providers/offline_data_provider.dart';
import 'report_detail_page.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Map<String, dynamic>> batches = [];
  List<Map<String, dynamic>> batchRecords = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() {
        loading = false;
      });
      return;
    }

    setState(() => loading = true);

    try {
      final isOnline = ConnectivityManager.instance.isOnline;

      if (isOnline) {
        // Try to fetch from server when online
        final fetchedBatches = await SupabaseService().fetchBatches(user.id);
        // Fetch all daily records for the user
        final dailyRecords = await SupabaseService().fetchDailyRecords(user.id);
        // Fetch all batch records for each daily record
        List<Map<String, dynamic>> allBatchRecords = [];
        for (final dr in dailyRecords) {
          final brs = await SupabaseService().fetchBatchRecordsForDailyRecord(
            dr['id'],
          );
          for (final br in brs) {
            // Attach the record date to the batch record for sorting
            br['record_date'] = dr['record_date'];
            allBatchRecords.add(br);
          }
        }

        // Cache the reports data for offline use
        await OfflineDataProvider.instance.cacheReports(
          user.id,
          allBatchRecords,
        );
        await OfflineDataProvider.instance.cacheBatches(
          user.id,
          fetchedBatches,
        );

        setState(() {
          batches = fetchedBatches;
          batchRecords = allBatchRecords;
          loading = false;
        });
      } else {
        // Load from cache when offline
        await _loadOfflineData();
      }
    } catch (e) {
      print('[ReportsPage] Error fetching online data: $e');
      // Fallback to offline data on error
      await _loadOfflineData();
    }
  }

  Future<void> _loadOfflineData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      // Load cached batches and reports
      await OfflineDataProvider.instance.loadBatches();
      final cachedBatches = OfflineDataProvider.instance.batches;
      final cachedReports = await OfflineDataProvider.instance.getCachedReports(
        user.id,
      );

      setState(() {
        batches = cachedBatches.map((b) => b.toJson()).toList();
        batchRecords = cachedReports;
        loading = false;
      });

      print(
        '[ReportsPage] Loaded ${batches.length} batches and ${batchRecords.length} reports from cache',
      );
    } catch (e) {
      print('[ReportsPage] Error loading offline data: $e');
      setState(() {
        batches = [];
        batchRecords = [];
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasBatches = batches.isNotEmpty;

    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          context.pop();
        } else {
          context.go('/');
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          ),
          title: Text('my_farm_reports'.tr()),
          actions: [
            // Offline indicator - only show when offline
            ValueListenableBuilder<bool>(
              valueListenable: ConnectivityManager.instance.isOnlineNotifier,
              builder: (context, isOnline, _) {
                if (isOnline) return const SizedBox.shrink();

                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.lightYellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_off, size: 16, color: CustomColors.text),
                      const SizedBox(width: 4),
                      Text(
                        'offline_mode'.tr(),
                        style: TextStyle(
                          color: CustomColors.text,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : !hasBatches
            ? _buildNoBatchesView()
            : _buildReportsView(),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildNoBatchesView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/amico.png',
              width: 140,
              height: 140,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              'It seems you have not created your batches yet, go to batches and add a chick batch to continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: CustomColors.text,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: CustomColors.buttonGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton.icon(
                  label: Text(
                    'Go to Batches',
                    style: TextStyle(color: CustomColors.text),
                  ),
                  onPressed: () {
                    context.go('/batches', extra: {'fromReportsPage': true});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: CustomColors.text,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsView() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.go('/report-entry');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: CustomColors.text,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ).copyWith(backgroundColor: WidgetStateProperty.all(null)),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: CustomColors.buttonGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: CustomColors.text),
                      const SizedBox(width: 8),
                      Text(
                        'Add Farm Report',
                        style: const TextStyle(color: CustomColors.text),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Sync status widget
        ValueListenableBuilder<int>(
          valueListenable: ConnectivityManager.instance.pendingReportsNotifier,
          builder: (context, pendingCount, _) {
            if (pendingCount == 0) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: CustomColors.lightYellow,
                border: Border.all(
                  color: CustomColors.secondary.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.cloud_upload, color: CustomColors.text, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '$pendingCount ${'sync_pending'.tr()}',
                      style: TextStyle(
                        color: CustomColors.text,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final result = await ConnectivityManager.instance
                          .manualSync();
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(result.message)));
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: CustomColors.primary,
                    ),
                    child: Text('sync_now'.tr()),
                  ),
                ],
              ),
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'previous_records'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      context.go('/all-reports');
                    },
                    icon: const Icon(Icons.list_alt, size: 18),
                    label: Text('see_all_reports'.tr()),
                    style: TextButton.styleFrom(
                      foregroundColor: CustomColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // List of previous records derived from batches with batch records
        Expanded(
          child: RefreshIndicator(
            onRefresh: fetchData,
            child: ListView(
              children: batches
                  .map((batch) {
                    // Find all batch records for this batch
                    final recordsForBatch = batchRecords
                        .where((br) => br['batch_id'] == batch['id'])
                        .toList();
                    if (recordsForBatch.isEmpty) return SizedBox.shrink();
                    // Sort by record_date descending
                    recordsForBatch.sort((a, b) {
                      final da = a['record_date'] ?? '';
                      final db = b['record_date'] ?? '';
                      return db.compareTo(da);
                    });
                    final latestRecord = recordsForBatch.first;
                    // Format date
                    String formattedDate = 'Unknown Date';
                    final rawDate = latestRecord['record_date'];
                    if (rawDate is String && rawDate.isNotEmpty) {
                      try {
                        final dt = DateTime.parse(rawDate);
                        formattedDate = DateFormat('yyyy-MM-dd').format(dt);
                      } catch (_) {
                        formattedDate = rawDate;
                      }
                    } else if (rawDate is DateTime) {
                      formattedDate = DateFormat('yyyy-MM-dd').format(rawDate);
                    }
                    return ListTile(
                      title: Text(batch['name'] ?? 'Unknown Batch'),
                      subtitle: Text(
                        '${formattedDate} • ${batch['bird_type'] ?? 'Unknown Type'}',
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ReportDetailPage(
                              report: latestRecord,
                              batch: batch,
                            ),
                          ),
                        );
                      },
                    );
                  })
                  .where((w) => w is! SizedBox)
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
