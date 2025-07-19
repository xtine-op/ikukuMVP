import 'package:flutter/material.dart';
import '../../batches/data/batch_model.dart';
import '../../../app_theme.dart';

class EggProductionPage extends StatelessWidget {
  final Batch? selectedBatch;
  final bool? collectedEggs;
  final ValueChanged<bool?> onCollectedEggsChanged;
  final int? eggsCollected;
  final ValueChanged<String> onEggsCollectedChanged;
  final bool? gradeEggs;
  final ValueChanged<bool?> onGradeEggsChanged;
  final int? bigEggs;
  final ValueChanged<String> onBigEggsChanged;
  final int? deformedEggs;
  final ValueChanged<String> onDeformedEggsChanged;
  final int? brokenEggs;
  final ValueChanged<String> onBrokenEggsChanged;
  final VoidCallback onContinue;

  const EggProductionPage({
    super.key,
    required this.selectedBatch,
    required this.collectedEggs,
    required this.onCollectedEggsChanged,
    required this.eggsCollected,
    required this.onEggsCollectedChanged,
    required this.gradeEggs,
    required this.onGradeEggsChanged,
    required this.bigEggs,
    required this.onBigEggsChanged,
    required this.deformedEggs,
    required this.onDeformedEggsChanged,
    required this.brokenEggs,
    required this.onBrokenEggsChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final isLayerOrKienyeji =
        selectedBatch != null &&
        (selectedBatch!.birdType.toLowerCase().contains('layer') ||
            selectedBatch!.birdType.toLowerCase().contains('kienyeji'));
    if (!isLayerOrKienyeji) {
      return const Center(
        child: Text('No egg production for this batch type.'),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Have you collected eggs today?'),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: collectedEggs,
                  onChanged: onCollectedEggsChanged,
                ),
                const Text('Yes'),
                Radio<bool>(
                  value: false,
                  groupValue: collectedEggs,
                  onChanged: onCollectedEggsChanged,
                ),
                const Text('No'),
              ],
            ),
            if (collectedEggs == true) ...[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'How many eggs have you collected?',
                  border: OutlineInputBorder(),
                  filled: false,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                ),
                onChanged: onEggsCollectedChanged,
              ),
              const SizedBox(height: 8),
              const Text('Would you like to grade your eggs?'),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: gradeEggs,
                    onChanged: onGradeEggsChanged,
                  ),
                  const Text('Yes'),
                  Radio<bool>(
                    value: false,
                    groupValue: gradeEggs,
                    onChanged: onGradeEggsChanged,
                  ),
                  const Text('No'),
                ],
              ),
              if (gradeEggs == true) ...[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Number of big eggs',
                    border: OutlineInputBorder(),
                    filled: false,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  onChanged: onBigEggsChanged,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Number of deformed eggs',
                    border: OutlineInputBorder(),
                    filled: false,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  onChanged: onDeformedEggsChanged,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Number of broken eggs',
                    border: OutlineInputBorder(),
                    filled: false,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  onChanged: onBrokenEggsChanged,
                ),
                const SizedBox(height: 8),
              ],
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: onContinue,
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
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(color: CustomColors.text),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
