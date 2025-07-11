import 'package:flutter/material.dart';
import '../../batches/data/batch_model.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';

class ReviewAndSavePage extends StatelessWidget {
  final Batch? selectedBatch;
  final String? chickenReduction;
  final String? reductionReason;
  final int? reductionCount;
  final bool? collectedEggs;
  final int? eggsCollected;
  final bool? gradeEggs;
  final int? bigEggs;
  final int? deformedEggs;
  final int? brokenEggs;
  final InventoryItem? selectedFeed;
  final double? feedAmount;
  final InventoryItem? selectedVaccine;
  final double? vaccineAmount;
  final Map<InventoryItem, double> otherMaterialsUsed;
  final String? notes;
  final VoidCallback onSave;

  const ReviewAndSavePage({
    super.key,
    required this.selectedBatch,
    required this.chickenReduction,
    required this.reductionReason,
    required this.reductionCount,
    required this.collectedEggs,
    required this.eggsCollected,
    required this.gradeEggs,
    required this.bigEggs,
    required this.deformedEggs,
    required this.brokenEggs,
    required this.selectedFeed,
    required this.feedAmount,
    required this.selectedVaccine,
    required this.vaccineAmount,
    required this.otherMaterialsUsed,
    required this.notes,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review Today\'s Report',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (selectedBatch != null)
            Text(
              'Batch: ${selectedBatch!.name} (${selectedBatch!.birdType}), Age: ${selectedBatch!.ageInDays}',
            ),
          if (chickenReduction != null)
            Text('Chicken Reduction: $chickenReduction'),
          if (reductionReason != null)
            Text('Reduction Reason: $reductionReason'),
          if (reductionCount != null) Text('Reduction Count: $reductionCount'),
          if (collectedEggs != null)
            Text(
              'Eggs Collected: ${collectedEggs == true ? (eggsCollected ?? 0) : 'No'}',
            ),
          if (gradeEggs == true)
            Text(
              'Egg Grading: Big: ${bigEggs ?? 0}, Deformed: ${deformedEggs ?? 0}, Broken: ${brokenEggs ?? 0}',
            ),
          if (selectedFeed != null)
            Text(
              'Feed Used: ${selectedFeed!.name} (${feedAmount != null ? feedAmount!.toStringAsFixed(2) : '0'} Kg)',
            ),
          if (selectedVaccine != null)
            Text(
              'Vaccine Used: ${selectedVaccine!.name} (${vaccineAmount != null ? vaccineAmount!.toStringAsFixed(2) : '0'} L)',
            ),
          if (otherMaterialsUsed.isNotEmpty)
            ...otherMaterialsUsed.entries.map(
              (e) =>
                  Text('Other: ${e.key.name} (${e.value.toStringAsFixed(2)})'),
            ),
          if (notes != null && notes!.isNotEmpty) Text('Notes: $notes'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSave,
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
            child: Ink(
              decoration: BoxDecoration(
                gradient: CustomColors.buttonGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minHeight: 48),
                child: const Text('Save Report'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
