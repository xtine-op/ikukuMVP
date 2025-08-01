import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../batches/data/batch_model.dart';
import '../../../app_theme.dart';

class AdditionalNotesPage extends StatelessWidget {
  final Batch? selectedBatch;
  final String? notes;
  final ValueChanged<String> onNotesChanged;
  final VoidCallback onContinue;

  const AdditionalNotesPage({
    super.key,
    required this.selectedBatch,
    required this.notes,
    required this.onNotesChanged,
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
            'additional_notes_title'.tr(
              namedArgs: {
                'batch': selectedBatch?.name ?? '',
                'type': selectedBatch?.birdType ?? '',
              },
            ),
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              labelText: 'notes_label'.tr(),
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
            maxLines: 3,
            onChanged: onNotesChanged,
          ),
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
                child: Text(
                  'continue'.tr(),
                  style: const TextStyle(color: CustomColors.text),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
