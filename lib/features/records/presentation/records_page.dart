import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../../shared/services/supabase_service.dart';
import '../data/daily_record_model.dart';
import 'record_detail_page.dart';
import '../../batches/data/batch_model.dart';
import '../data/batch_record_model.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  List<DailyRecord> records = [];
  Map<String, Batch?> batchInfo = {}; // dailyRecordId -> Batch
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    final data = await SupabaseService().fetchDailyRecords(user.id);
    final recs = data.map((e) => DailyRecord.fromJson(e)).toList();
    setState(() {
      records = recs;
      loading = false;
    });
    // Fetch batch info for each record
    for (final record in recs) {
      fetchBatchInfoForRecord(record);
    }
  }

  Future<void> fetchBatchInfoForRecord(DailyRecord record) async {
    final batchRecordsRaw = await SupabaseService()
        .fetchBatchRecordsForDailyRecord(record.id);
    if (batchRecordsRaw.isNotEmpty) {
      final batchRecord = BatchRecord.fromJson(batchRecordsRaw.first);
      final batchesRaw = await SupabaseService().fetchBatches(record.userId);
      final batch = batchesRaw
          .map((e) => Batch.fromJson(e))
          .firstWhere(
            (b) => b.id == batchRecord.batchId,
            orElse: () => Batch.empty(record.userId),
          );
      setState(() {
        batchInfo[record.id] = batch;
      });
    } else {
      setState(() {
        batchInfo[record.id] = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? const BackButton() : null,
        title: const Text('My Farm Records'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, i) {
                final record = records[i];
                final isToday =
                    record.recordDate.year == today.year &&
                    record.recordDate.month == today.month &&
                    record.recordDate.day == today.day;
                final batch = batchInfo[record.id];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: batch == null
                        ? const Text('Loading batch info...')
                        : (batch.name.isEmpty
                              ? const Text('Batch info unavailable')
                              : Text(
                                  '${batch.name} (${batch.birdType})',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                    subtitle: Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(record.recordDate.toLocal())}',
                    ),
                    trailing: isToday
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Report done',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RecordDetailPage(record: record),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
