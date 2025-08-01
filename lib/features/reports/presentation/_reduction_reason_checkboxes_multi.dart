import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReductionReasonCheckboxesMulti extends StatefulWidget {
  final Map<String, int> reductionCounts;
  final ValueChanged<Map<String, int>> onCountsChanged;

  ReductionReasonCheckboxesMulti({
    required this.reductionCounts,
    required this.onCountsChanged,
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
    };
    _counts = {
      'curled': (widget.reductionCounts['curled']?.toString() ?? ''),
      'stolen': (widget.reductionCounts['stolen']?.toString() ?? ''),
      'death': (widget.reductionCounts['death']?.toString() ?? ''),
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
                    Text(reason[0].toUpperCase() + reason.substring(1)),
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
              (reason) => Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: tr(
                      'how_many_reason',
                      namedArgs: {
                        'reason': reason[0].toUpperCase() + reason.substring(1),
                      },
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
            ),
      ],
    );
  }
}
