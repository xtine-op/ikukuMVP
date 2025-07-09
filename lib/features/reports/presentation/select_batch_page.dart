import 'package:flutter/material.dart';
import '../../batches/data/batch_model.dart';

class SelectBatchPage extends StatelessWidget {
  final List<Batch> batches;
  final Batch? selectedBatch;
  final ValueChanged<Batch> onBatchSelected;
  final VoidCallback onContinue;

  const SelectBatchPage({
    super.key,
    required this.batches,
    required this.selectedBatch,
    required this.onBatchSelected,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select a Batch to Report On',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...batches.map(
            (batch) => Card(
              color: selectedBatch?.id == batch.id ? Colors.green[100] : null,
              child: ListTile(
                title: Text(batch.name),
                subtitle: Text(
                  '${batch.birdType} • Age: ${batch.ageInDays} days',
                ),
                trailing: selectedBatch?.id == batch.id
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
                onTap: () => onBatchSelected(batch),
              ),
            ),
          ),
          if (selectedBatch == null)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Please select a batch to continue.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          const Spacer(),
          ElevatedButton(
            onPressed: selectedBatch != null ? onContinue : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
