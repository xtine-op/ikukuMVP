import 'package:flutter/material.dart';

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
          const Text('Have your chickens reduced today?'),
          Row(
            children: [
              Radio<String>(
                value: 'yes',
                groupValue: chickenReduction,
                onChanged: onReductionChanged,
              ),
              const Text('Yes'),
              Radio<String>(
                value: 'no',
                groupValue: chickenReduction,
                onChanged: onReductionChanged,
              ),
              const Text('No'),
            ],
          ),
          if (chickenReduction == 'yes') ...[
            const SizedBox(height: 8),
            const Text('What is the reason for the reduction?'),
            DropdownButton<String>(
              value: reductionReason,
              hint: const Text('Select reason'),
              items: const [
                DropdownMenuItem(value: 'curled', child: Text('Curled')),
                DropdownMenuItem(value: 'stolen', child: Text('Stolen')),
                DropdownMenuItem(value: 'death', child: Text('Death')),
              ],
              onChanged: onReasonChanged,
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Number reduced'),
              keyboardType: TextInputType.number,
              onChanged: onCountChanged,
            ),
          ],
          const Spacer(),
          ElevatedButton(
            onPressed: chickenReduction != null ? onContinue : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
