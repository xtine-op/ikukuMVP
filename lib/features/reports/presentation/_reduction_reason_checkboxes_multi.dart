import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReductionReasonCheckboxesMulti extends StatefulWidget {
  final Map<String, int> reductionCounts;
  final ValueChanged<Map<String, int>> onCountsChanged;
  final ValueChanged<double>? onSalesAmountChanged;
  final double? salesAmount;

  const ReductionReasonCheckboxesMulti({super.key, 
    required this.reductionCounts,
    required this.onCountsChanged,
    this.onSalesAmountChanged,
    this.salesAmount,
  });

  @override
  State<ReductionReasonCheckboxesMulti> createState() =>
      _ReductionReasonCheckboxesMultiState();
}

class _ReductionReasonCheckboxesMultiState
    extends State<ReductionReasonCheckboxesMulti> {
  late Map<String, bool> _checked;
  late Map<String, String> _counts;

  @override
  void initState() {
    super.initState();
    _checked = {
      'curled': (widget.reductionCounts['curled'] ?? 0) > 0,
      'stolen': (widget.reductionCounts['stolen'] ?? 0) > 0,
      'death': (widget.reductionCounts['death'] ?? 0) > 0,
      'sold': (widget.reductionCounts['sold'] ?? 0) > 0,
    };
    _counts = {
      'curled': (widget.reductionCounts['curled']?.toString() ?? ''),
      'stolen': (widget.reductionCounts['stolen']?.toString() ?? ''),
      'death': (widget.reductionCounts['death']?.toString() ?? ''),
      'sold': (widget.reductionCounts['sold']?.toString() ?? ''),
    };
  }

  void _emitCounts() {
    final result = <String, int>{};
    for (final key in _checked.keys) {
      result[key] = _checked[key]! ? int.tryParse(_counts[key] ?? '') ?? 0 : 0;
    }
    widget.onCountsChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkboxes row
        Row(
          children: _checked.keys
              .map(
                (reason) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _checked[reason],
                      onChanged: (val) {
                        setState(() {
                          _checked[reason] = val ?? false;
                        });
                        _emitCounts();
                      },
                    ),
                    Text(reason.tr()),
                    const SizedBox(width: 16),
                  ],
                ),
              )
              .toList(),
        ),
        // Inputs for checked reasons
        ..._checked.keys
            .where((reason) => _checked[reason] == true)
            .map(
              (reason) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: tr(
                          'how_many_reason',
                          namedArgs: {'reason': reason.tr()},
                        ),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        setState(() {
                          _counts[reason] = v;
                        });
                        _emitCounts();
                      },
                      controller: TextEditingController(text: _counts[reason]),
                    ),
                  ),
                  if (reason == 'sold' && widget.onSalesAmountChanged != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText:
                              'How nuch did you sell the chicken for?(Ksh)',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (v) {
                          final amount = double.tryParse(v) ?? 0.0;
                          widget.onSalesAmountChanged?.call(amount);
                        },
                        controller: TextEditingController(
                          text: widget.salesAmount?.toString() ?? '',
                        ),
                      ),
                    ),
                ],
              ),
            ),
      ],
    );
  }
}
