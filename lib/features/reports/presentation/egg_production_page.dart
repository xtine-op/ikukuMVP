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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'egg_production'.tr(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Batch summary card
                  if (selectedBatch != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE6E8EC)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'selected_batch'.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            selectedBatch!.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${selectedBatch!.birdType.toUpperCase()} • ${selectedBatch!.totalChickens} ${'birds'.tr()} • ${selectedBatch!.currentAgeInDays} ${'days_old'.tr()}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                  Text(
                    'have_collected_eggs_today'.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: collectedEggs,
                        onChanged: onCollectedEggsChanged,
                        activeColor: CustomColors.primary,
                      ),
                      Text('yes'.tr()),
                      const SizedBox(width: 24),
                      Radio<bool>(
                        value: false,
                        groupValue: collectedEggs,
                        onChanged: onCollectedEggsChanged,
                        activeColor: CustomColors.primary,
                      ),
                      Text('no'.tr()),
                    ],
                  ),

                  if (collectedEggs == true) ...[
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'eggs_collected_count'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                      ),
                      onChanged: onEggsCollectedChanged,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'would_like_to_grade_eggs'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: gradeEggs,
                          onChanged: onGradeEggsChanged,
                          activeColor: CustomColors.primary,
                        ),
                        Text('yes'.tr()),
                        const SizedBox(width: 24),
                        Radio<bool>(
                          value: false,
                          groupValue: gradeEggs,
                          onChanged: onGradeEggsChanged,
                          activeColor: CustomColors.primary,
                        ),
                        Text('no'.tr()),
                      ],
                    ),

                    if (gradeEggs == true) ...[
                      const SizedBox(height: 24),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'big_eggs_count'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        onChanged: onBigEggsChanged,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'deformed_eggs_count'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        onChanged: onDeformedEggsChanged,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'broken_eggs_count'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        onChanged: onBrokenEggsChanged,
                      ),
                    ],
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Continue button at the bottom
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: CustomColors.text,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ).copyWith(backgroundColor: WidgetStateProperty.all(null)),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: CustomColors.buttonGradient,
                  borderRadius: BorderRadius.circular(8),
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
          ),
        ],
      ),
    );
  }
}
