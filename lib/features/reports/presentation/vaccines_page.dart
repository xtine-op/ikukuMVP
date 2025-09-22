import 'package:easy_localization/easy_localization.dart';
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
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _selectedVaccines = List<Map<String, dynamic>>.from(
      widget.selectedVaccines,
    );
    _initializeControllers();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    for (final vaccine in _selectedVaccines) {
      final name = vaccine['name'] as String;
      if (!_controllers.containsKey(name)) {
        _controllers[name] = TextEditingController(
          text: vaccine['quantity']?.toString() ?? '',
        );
      }
    }
  }

  void _toggleVaccine(InventoryItem vaccine, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedVaccines.any((v) => v['name'] == vaccine.name)) {
          _selectedVaccines.add({'name': vaccine.name, 'quantity': null});
          _controllers[vaccine.name] = TextEditingController();
        }
      } else {
        _selectedVaccines.removeWhere((v) => v['name'] == vaccine.name);
        _controllers[vaccine.name]?.dispose();
        _controllers.remove(vaccine.name);
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
                  'cannot_use_more_than'.tr(
                    namedArgs: {
                      'quantity': vaccine.quantity.toString(),
                      'unit': 'lit'.tr(),
                      'item': vaccine.name,
                    },
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
            // Reset the controller to the previous valid value
            _controllers[vaccineName]?.text =
                _selectedVaccines[idx]['quantity']?.toString() ?? '';
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
        Text(
          'select_vaccines_today'.tr(),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        ...widget.vaccines.map((vaccine) {
          final isSelected = _selectedVaccines.any(
            (v) => v['name'] == vaccine.name,
          );
          return CheckboxListTile(
            value: isSelected,
            title: Text(
              '${vaccine.name} (${"stock".tr()}: ${vaccine.quantity} ${"lit".tr()})',
            ),
            onChanged: (checked) => _toggleVaccine(vaccine, checked ?? false),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),
        const SizedBox(height: 16),
        ..._selectedVaccines.map((v) {
          final vaccineName = v['name'] as String;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vaccineName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _controllers[vaccineName],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  hintText: 'enter_quantity_litres'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixText: 'lit'.tr(),
                ),
                onChanged: (val) => _updateQuantity(vaccineName, val),
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
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
                child: Text(
                  'continue'.tr(),
                  style: const TextStyle(color: CustomColors.text),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
