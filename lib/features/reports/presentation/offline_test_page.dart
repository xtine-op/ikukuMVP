import 'package:flutter/material.dart';
import '../../../shared/services/offline_service.dart';
import '../../../shared/services/connectivity_manager.dart';

class OfflineTestPage extends StatefulWidget {
  const OfflineTestPage({super.key});

  @override
  State<OfflineTestPage> createState() => _OfflineTestPageState();
}

class _OfflineTestPageState extends State<OfflineTestPage> {
  String _status = 'Ready to test';
  bool _isOnline = false;
  int _pendingReports = 0;

  @override
  void initState() {
    super.initState();
    _updateStatus();
  }

  Future<void> _updateStatus() async {
    try {
      final isOnline = await OfflineService.instance.isOnline();
      final pendingCount = await OfflineService.instance
          .getPendingReportsCount();

      setState(() {
        _isOnline = isOnline;
        _pendingReports = pendingCount;
        _status = 'Online: $isOnline, Pending: $pendingCount';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }

  Future<void> _testOfflineSave() async {
    setState(() {
      _status = 'Testing offline save...';
    });

    try {
      final testData = {
        'user_id': 'test-user-123',
        'record_date': DateTime.now().toIso8601String(),
        'notes': 'Test offline report',
        'batch_id': 'test-batch-123',
        'chicken_reduction': false,
        'chickens_sold': 0,
        'chickens_died': 0,
        'chickens_curled': 0,
        'chickens_stolen': 0,
        'eggs_collected': 10,
        'grade_eggs': true,
        'eggs_standard': 8, // Fixed: big_eggs -> eggs_standard
        'eggs_deformed': 1, // Fixed: deformed_eggs -> eggs_deformed
        'eggs_broken': 1, // Fixed: broken_eggs -> eggs_broken
        'selected_feeds': [],
        'selected_vaccines': [],
        'selected_other_materials': [],
      };

      final reportId = await OfflineService.instance.saveFarmReportOffline(
        testData,
      );

      setState(() {
        _status = 'Successfully saved offline report: $reportId';
      });

      await _updateStatus();
    } catch (e) {
      setState(() {
        _status = 'Error saving offline: $e';
      });
    }
  }

  Future<void> _testSync() async {
    setState(() {
      _status = 'Testing sync...';
    });

    try {
      final result = await ConnectivityManager.instance.manualSync();

      setState(() {
        _status = 'Sync result: ${result.message}';
      });

      await _updateStatus();
    } catch (e) {
      setState(() {
        _status = 'Error syncing: $e';
      });
    }
  }

  Future<void> _viewPendingReports() async {
    setState(() {
      _status = 'Loading pending reports...';
    });

    try {
      final reports = await OfflineService.instance.getPendingReports();

      setState(() {
        _status = 'Found ${reports.length} pending reports';
      });

      if (reports.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pending Reports'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return ListTile(
                    title: Text('Report ${report.id.substring(0, 8)}...'),
                    subtitle: Text('Created: ${report.createdAt}'),
                    trailing: Text('Batch: ${report.reportData['batch_id']}'),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() {
        _status = 'Error loading reports: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(_status),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _isOnline ? Icons.cloud : Icons.cloud_off,
                          color: _isOnline ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(_isOnline ? 'Online' : 'Offline'),
                        const Spacer(),
                        Text('Pending: $_pendingReports'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateStatus,
              child: const Text('Refresh Status'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testOfflineSave,
              child: const Text('Test Offline Save'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _testSync,
              child: const Text('Test Sync'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _viewPendingReports,
              child: const Text('View Pending Reports'),
            ),
          ],
        ),
      ),
    );
  }
}
