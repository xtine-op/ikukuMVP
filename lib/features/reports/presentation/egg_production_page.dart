import 'package:flutter/material.dart';
import '../../batches/data/batch_model.dart';
import '../../../app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

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
    print(
      '[EggProductionPage] Building with batch: ${selectedBatch?.name} (${selectedBatch?.birdType})',
    );

    // Add a simple test to see if the page is being rendered
    print('[EggProductionPage] Rendering egg production page');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('have_collected_eggs_today'.tr()),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: collectedEggs,
                  onChanged: onCollectedEggsChanged,
                ),
                Text('yes'.tr()),
                Radio<bool>(
                  value: false,
                  groupValue: collectedEggs,
                  onChanged: onCollectedEggsChanged,
                ),
                Text('no'.tr()),
              ],
            ),
            if (collectedEggs == true) ...[
              TextField(
                decoration: InputDecoration(
                  labelText: 'how_many_eggs_collected'.tr(),
                  border: const OutlineInputBorder(),
                  filled: false,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                ),
                onChanged: onEggsCollectedChanged,
              ),
              const SizedBox(height: 8),
              Text('would_like_to_grade_eggs'.tr()),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: gradeEggs,
                    onChanged: onGradeEggsChanged,
                  ),
                  Text('yes'.tr()),
                  Radio<bool>(
                    value: false,
                    groupValue: gradeEggs,
                    onChanged: onGradeEggsChanged,
                  ),
                  Text('no'.tr()),
                ],
              ),
              if (gradeEggs == true) ...[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'number_of_big_eggs'.tr(),
                    border: const OutlineInputBorder(),
                    filled: false,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  onChanged: onBigEggsChanged,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'number_of_deformed_eggs'.tr(),
                    border: const OutlineInputBorder(),
                    filled: false,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  onChanged: onDeformedEggsChanged,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'number_of_broken_eggs'.tr(),
                    border: const OutlineInputBorder(),
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
            const SizedBox(height: 24),
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
                  child: Text(
                    'continue'.tr(),
                    style: const TextStyle(color: CustomColors.text),
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
