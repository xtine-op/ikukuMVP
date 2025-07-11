import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/services/supabase_service.dart';
import '../data/daily_record_model.dart';
import 'record_detail_page.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  List<DailyRecord> records = [];
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
    setState(() {
      records = data.map((e) => DailyRecord.fromJson(e)).toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                return ListTile(
                  title: Text(
                    // Show created date as title (no batch name in DailyRecord)
                    'Created: ${record.createdAt.toLocal().toString().split(' ')[0]}',
                  ),
                  subtitle: Text(
                    'Record Date: ${record.recordDate.toLocal().toString().split(' ')[0]}',
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RecordDetailPage(record: record),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
