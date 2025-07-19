import 'package:flutter/material.dart';
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
            'Write any additional notes for this batch (${selectedBatch?.name ?? ''} - ${selectedBatch?.birdType ?? ''})',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              labelText: 'Notes',
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
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(color: CustomColors.text),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
