import 'package:flutter/material.dart';
import '../../inventory/data/inventory_item_model.dart';

class VaccinesPage extends StatelessWidget {
  final List<InventoryItem> vaccines;
  final InventoryItem? selectedVaccine;
  final ValueChanged<InventoryItem?> onVaccineSelected;
  final double? vaccineAmount;
  final ValueChanged<String> onVaccineAmountChanged;
  final VoidCallback onContinue;

  const VaccinesPage({
    super.key,
    required this.vaccines,
    required this.selectedVaccine,
    required this.onVaccineSelected,
    required this.vaccineAmount,
    required this.onVaccineAmountChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Have you used any vaccines today?'),
          Row(
            children: [
              Radio<String>(
                value: 'yes',
                groupValue:
                    (selectedVaccine != null &&
                        vaccineAmount != null &&
                        vaccineAmount! > 0)
                    ? 'yes'
                    : 'no',
                onChanged: (v) {
                  // When 'yes' is selected, do nothing (let user pick vaccine)
                },
              ),
              const Text('Yes'),
              Radio<String>(
                value: 'no',
                groupValue:
                    (selectedVaccine != null &&
                        vaccineAmount != null &&
                        vaccineAmount! > 0)
                    ? 'yes'
                    : 'no',
                onChanged: (v) {
                  // When 'no' is selected, clear vaccine selection and amount
                  onVaccineSelected(null);
                  onVaccineAmountChanged('');
                },
              ),
              const Text('No'),
            ],
          ),
          if ((selectedVaccine != null && vaccineAmount != null && vaccineAmount! > 0)) ...[
            DropdownButton<InventoryItem>(
              value: selectedVaccine,
              hint: const Text('Select vaccine'),
              items: vaccines
                  .map(
                    (vaccine) => DropdownMenuItem(
                      value: vaccine,
                      child: Text(
                        '${vaccine.name} (Stock: ${vaccine.quantity})',
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onVaccineSelected,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount used today (Litres)',
              ),
              keyboardType: TextInputType.number,
              onChanged: onVaccineAmountChanged,
            ),
            if (vaccineAmount != null && vaccineAmount! > (selectedVaccine?.quantity ?? 0))
              const Text(
                'Cannot use more vaccine than available in store.',
                style: TextStyle(color: Colors.red),
              ),
          ],
          const Spacer(),
          ElevatedButton(
            onPressed: (selectedVaccine != null && vaccineAmount != null && vaccineAmount! > 0) ? onContinue : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
