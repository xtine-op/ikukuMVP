import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app_theme.dart';
import '../../batches/data/batch_model.dart';

class SelectBatchPage extends StatelessWidget {
  final List<Batch> batches;
  final Batch? selectedBatch;
  final ValueChanged<Batch> onBatchSelected;
  final VoidCallback onContinue;
  final List<String> batchesReportedToday;

  const SelectBatchPage({
    super.key,
    required this.batches,
    required this.selectedBatch,
    required this.onBatchSelected,
    required this.onContinue,
    required this.batchesReportedToday,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select the batch you are reporting for',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: batches
                  .map(
                    (batch) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: selectedBatch?.id == batch.id
                            ? CustomColors
                                  .lightYellow // Light yellow for selected
                            : batchesReportedToday.contains(batch.id)
                            ? Colors.grey[200] // Grey for already reported
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x1400681D),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  batch.name,
                                  style: TextStyle(
                                    color: CustomColors.text,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: batch.birdType.toLowerCase() == 'broiler'
                                    ? Colors.green[100]
                                    : batch.birdType.toLowerCase() == 'layers'
                                    ? CustomColors.secondary
                                    : batch.birdType.toLowerCase() == 'kienyeji'
                                    ? Colors.orange[100]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                batch.birdType,
                                style: TextStyle(
                                  color:
                                      batch.birdType.toLowerCase() == 'broiler'
                                      ? Colors.green[800]
                                      : batch.birdType.toLowerCase() == 'layers'
                                      ? Colors.white
                                      : batch.birdType.toLowerCase() ==
                                            'kienyeji'
                                      ? Colors.orange[800]
                                      : Colors.grey[800],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                'batch_age_days'.tr(
                                  namedArgs: {
                                    'days': batch.currentAgeInDays.toString(),
                                  },
                                ),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: selectedBatch?.id == batch.id
                            ? Icon(
                                Icons.check_circle,
                                color: CustomColors.secondary,
                              )
                            : null,
                        onTap: () {
                          onBatchSelected(batch);
                          onContinue();
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
