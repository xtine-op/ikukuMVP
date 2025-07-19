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
  final dynamic selectedBatch; // Add this line

  const ChickenReductionPage({
    super.key,
    required this.chickenReduction,
    required this.onReductionChanged,
    required this.reductionReason,
    required this.onReasonChanged,
    required this.reductionCount,
    required this.onCountChanged,
    required this.onContinue,
    this.selectedBatch, // Add this line
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
          // Remove yellow card and use a plain container for form fields
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Have your chickens reduced today?',
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
                const SizedBox(height: 24),
                Text(
                  'What is the reason for the reduction?',
                  style: TextStyle(color: CustomColors.text, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _ReductionReasonCheckboxes(
                  selectedReasons: reductionReason,
                  onReasonChanged: onReasonChanged,
                  onCountChanged: onCountChanged,
                  reductionCount: reductionCount,
                  showCountsBelow: true,
                ),
              ],
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
                  ).copyWith(backgroundColor: MaterialStateProperty.all(null)),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: CustomColors.buttonGradient,
                      borderRadius: BorderRadius.circular(8),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReductionReasonCheckboxes extends StatefulWidget {
  final String? selectedReasons;
  final ValueChanged<String?> onReasonChanged;
  final ValueChanged<String> onCountChanged;
  final int? reductionCount;
  final bool showCountsBelow;

  const _ReductionReasonCheckboxes({
    required this.selectedReasons,
    required this.onReasonChanged,
    required this.onCountChanged,
    required this.reductionCount,
    this.showCountsBelow = false,
  });

  @override
  State<_ReductionReasonCheckboxes> createState() =>
      _ReductionReasonCheckboxesState();
}

class _ReductionReasonCheckboxesState
    extends State<_ReductionReasonCheckboxes> {
  final Map<String, bool> _checked = {
    'curled': false,
    'stolen': false,
    'death': false,
  };
  final Map<String, String> _counts = {'curled': '', 'stolen': '', 'death': ''};

  @override
  void initState() {
    super.initState();
    if (widget.selectedReasons != null) {
      for (final reason in _checked.keys) {
        _checked[reason] = widget.selectedReasons!.contains(reason);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkedReasons = _checked.keys
        .where((r) => _checked[r] == true)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkboxes
        ..._checked.keys.map(
          (reason) => Row(
            children: [
              Checkbox(
                value: _checked[reason],
                onChanged: (val) {
                  setState(() {
                    _checked[reason] = val ?? false;
                  });
                  final selected = _checked.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .join(',');
                  widget.onReasonChanged(selected.isEmpty ? null : selected);
                },
              ),
              Text(reason[0].toUpperCase() + reason.substring(1)),
            ],
          ),
        ),
        if (widget.showCountsBelow && checkedReasons.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final reason in checkedReasons)
                  Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'How many chickens were $reason?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
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
                      onChanged: (v) {
                        _counts[reason] = v;
                        widget.onCountChanged(v);
                      },
                    ),
                  ),
              ],
            ),
          ),
        if (!widget.showCountsBelow)
          ..._checked.keys
              .where((reason) => _checked[reason] == true)
              .map(
                (reason) => Padding(
                  padding: const EdgeInsets.only(left: 32, bottom: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'How many chickens were $reason?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
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
                    onChanged: (v) {
                      _counts[reason] = v;
                      widget.onCountChanged(v);
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
