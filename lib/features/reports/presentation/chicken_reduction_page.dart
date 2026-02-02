import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import 'widgets/_reduction_reason_checkboxes_multi.dart';

class ChickenReductionPage extends StatelessWidget {
  final String? chickenReduction;
  final ValueChanged<String?> onReductionChanged;
  final Map<String, int> reductionCounts;
  final ValueChanged<Map<String, int>> onCountsChanged;
  final VoidCallback onContinue;
  final dynamic selectedBatch;
  final double? salesAmount;
  final ValueChanged<double>? onSalesAmountChanged;

  const ChickenReductionPage({
    super.key,
    required this.chickenReduction,
    required this.onReductionChanged,
    required this.reductionCounts,
    required this.onCountsChanged,
    required this.onContinue,
    this.selectedBatch,
    this.salesAmount,
    this.onSalesAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 24),
            Text(
              'chicken_reduction'.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ), // Increased space between heading and summary
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
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 8),
            // Remove yellow card and use a plain container for form fields
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'have_chickens_reduced_today'.tr(),
                  style: TextStyle(color: CustomColors.text, fontSize: 16),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'yes',
                      groupValue: chickenReduction,
                      onChanged: onReductionChanged,
                      activeColor: CustomColors.primary,
                    ),
                    Text('yes'.tr()),
                    Radio<String>(
                      value: 'no',
                      groupValue: chickenReduction,
                      onChanged: onReductionChanged,
                      activeColor: CustomColors.primary,
                    ),
                    Text('no'.tr()),
                  ],
                ),
                if (chickenReduction == 'yes') ...[
                  const SizedBox(height: 24),
                  Text(
                    'reduction_reason'.tr(),
                    style: TextStyle(color: CustomColors.text, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ReductionReasonCheckboxesMulti(
                    counts: reductionCounts,
                    onCountsChanged: onCountsChanged,
                    salesAmount: salesAmount,
                    onSalesAmountChanged: onSalesAmountChanged,
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onContinue,
                    style:
                        ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: CustomColors.text,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ).copyWith(
                          backgroundColor: WidgetStateProperty.all(null),
                        ),
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
          ],
        ),
      ),
    );
  }
}
