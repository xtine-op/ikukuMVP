import 'package:flutter/material.dart';
import '../data/daily_record_model.dart';

class RecordDetailPage extends StatelessWidget {
  final DailyRecord record;
  const RecordDetailPage({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Record ID: ${record.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('User ID: ${record.userId}'),
            const SizedBox(height: 8),
            Text('Record Date: ${record.recordDate.toLocal()}'),
            const SizedBox(height: 8),
            Text('Created At: ${record.createdAt.toLocal()}'),
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}
