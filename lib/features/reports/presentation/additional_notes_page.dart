import 'package:flutter/material.dart';
import '../../batches/data/batch_model.dart';

class AdditionalNotesPage extends StatelessWidget {
  final Batch? selectedBatch;
  final String? notes;
  final ValueChanged<String> onNotesChanged;
  final VoidCallback onContinue;

  const AdditionalNotesPage({
    super.key,
    required this.selectedBatch,
    required this.notes,
    required this.onNotesChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write any additional notes for this batch (${selectedBatch?.name ?? ''} - ${selectedBatch?.birdType ?? ''})',
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Notes'),
            maxLines: 3,
            onChanged: onNotesChanged,
          ),
          const Spacer(),
          ElevatedButton(onPressed: onContinue, child: const Text('Continue')),
        ],
      ),
    );
  }
}
