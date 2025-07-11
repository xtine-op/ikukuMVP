import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class ChickenReductionPage extends StatelessWidget {
  final String? chickenReduction;
  final ValueChanged<String?> onReductionChanged;
  final String? reductionReason;
  final ValueChanged<String?> onReasonChanged;
  final int? reductionCount;
  final ValueChanged<String> onCountChanged;
  final VoidCallback onContinue;

  const ChickenReductionPage({
    super.key,
    required this.chickenReduction,
    required this.onReductionChanged,
    required this.reductionReason,
    required this.onReasonChanged,
    required this.reductionCount,
    required this.onCountChanged,
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
            'Chicken Reduction',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            color: CustomColors.lightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have your chickens reduced today?',
                    style: TextStyle(color: CustomColors.text),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'yes',
                        groupValue: chickenReduction,
                        onChanged: onReductionChanged,
                        activeColor: CustomColors.primary,
                      ),
                      const Text('Yes'),
                      Radio<String>(
                        value: 'no',
                        groupValue: chickenReduction,
                        onChanged: onReductionChanged,
                        activeColor: CustomColors.primary,
                      ),
                      const Text('No'),
                    ],
                  ),
                  if (chickenReduction == 'yes') ...[
                    const SizedBox(height: 8),
                    Text(
                      'What is the reason for the reduction?',
                      style: TextStyle(color: CustomColors.text),
                    ),
                    DropdownButton<String>(
                      value: reductionReason,
                      hint: const Text('Select reason'),
                      items: const [
                        DropdownMenuItem(
                          value: 'curled',
                          child: Text('Curled'),
                        ),
                        DropdownMenuItem(
                          value: 'stolen',
                          child: Text('Stolen'),
                        ),
                        DropdownMenuItem(value: 'death', child: Text('Death')),
                      ],
                      onChanged: onReasonChanged,
                      dropdownColor: CustomColors.lightYellow,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'How many chickens?',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: onCountChanged,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: CustomColors.buttonGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
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
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
