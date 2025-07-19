import 'package:flutter/material.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';

class VaccinesPage extends StatelessWidget {
  final List<InventoryItem> vaccines;
  final List<Map<String, dynamic>> selectedVaccines;
  final void Function(List<Map<String, dynamic>>) onSelectedVaccinesChanged;
  final VoidCallback onContinue;

  const VaccinesPage({
    super.key,
    required this.vaccines,
    required this.selectedVaccines,
    required this.onSelectedVaccinesChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: _VaccinesSelector(
          vaccines: vaccines,
          selectedVaccines: selectedVaccines,
          onSelectedVaccinesChanged: onSelectedVaccinesChanged,
          onContinue: onContinue,
        ),
      ),
    );
  }
}

class _VaccinesSelector extends StatefulWidget {
  final List<InventoryItem> vaccines;
  final List<Map<String, dynamic>> selectedVaccines;
  final void Function(List<Map<String, dynamic>>) onSelectedVaccinesChanged;
  final VoidCallback onContinue;

  const _VaccinesSelector({
    required this.vaccines,
    required this.selectedVaccines,
    required this.onSelectedVaccinesChanged,
    required this.onContinue,
  });

  @override
  State<_VaccinesSelector> createState() => _VaccinesSelectorState();
}

class _VaccinesSelectorState extends State<_VaccinesSelector> {
  late List<Map<String, dynamic>> _selectedVaccines;

  @override
  void initState() {
    super.initState();
    _selectedVaccines = List<Map<String, dynamic>>.from(
      widget.selectedVaccines,
    );
  }

  void _toggleVaccine(InventoryItem vaccine, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedVaccines.any((v) => v['name'] == vaccine.name)) {
          _selectedVaccines.add({'name': vaccine.name, 'quantity': null});
        }
      } else {
        _selectedVaccines.removeWhere((v) => v['name'] == vaccine.name);
      }
      widget.onSelectedVaccinesChanged(_selectedVaccines);
    });
  }

  void _updateQuantity(String vaccineName, String value) {
    setState(() {
      final idx = _selectedVaccines.indexWhere((v) => v['name'] == vaccineName);
      if (idx != -1) {
        final quantity = double.tryParse(value);
        if (quantity != null && quantity >= 0) {
          // Find the vaccine to check available stock
          final vaccine = widget.vaccines.firstWhere(
            (v) => v.name == vaccineName,
          );
          if (quantity <= vaccine.quantity) {
            _selectedVaccines[idx]['quantity'] = quantity;
          } else {
            // Show error for exceeding stock
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Cannot use more than ${vaccine.quantity} litres of ${vaccine.name}',
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        } else {
          _selectedVaccines[idx]['quantity'] = null;
        }
        widget.onSelectedVaccinesChanged(_selectedVaccines);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the vaccines you used today.',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        ...widget.vaccines.map((vaccine) {
          final isSelected = _selectedVaccines.any(
            (v) => v['name'] == vaccine.name,
          );
          return CheckboxListTile(
            value: isSelected,
            title: Text('${vaccine.name} (Stock: ${vaccine.quantity})'),
            onChanged: (checked) => _toggleVaccine(vaccine, checked ?? false),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }).toList(),
        const SizedBox(height: 16),
        ..._selectedVaccines.map((v) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(v['name'], style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'Qty (Litres)',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: false,
                ),
                onChanged: (val) => _updateQuantity(v['name'], val),
                controller: TextEditingController(
                  text: v['quantity']?.toString() ?? '',
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onContinue,
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
        ),
      ],
    );
  }
}
