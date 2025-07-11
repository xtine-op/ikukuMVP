import 'package:flutter/material.dart';
import '../../../app_theme.dart';
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
          Text(
            'Select a Batch to Report On',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: batches
                  .map(
                    (batch) => Card(
                      color: selectedBatch?.id == batch.id
                          ? CustomColors.lightGreen.withOpacity(0.2)
                          : CustomColors.lightYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                      child: ListTile(
                        title: Text(
                          batch.name,
                          style: TextStyle(
                            color: CustomColors.text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${batch.birdType} • Age: ${batch.ageInDays} days',
                          style: TextStyle(color: CustomColors.textDisabled),
                        ),
                        trailing: selectedBatch?.id == batch.id
                            ? Icon(
                                Icons.check_circle,
                                color: CustomColors.primary,
                              )
                            : null,
                        onTap: () => onBatchSelected(batch),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (selectedBatch == null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Please select a batch to continue.',
                style: TextStyle(color: CustomColors.textDisabled),
              ),
            ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: CustomColors.buttonGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: selectedBatch != null ? onContinue : null,
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
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
