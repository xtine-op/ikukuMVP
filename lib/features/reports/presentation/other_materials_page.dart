import 'package:flutter/material.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';

class OtherMaterialsPage extends StatelessWidget {
  final List<InventoryItem> otherMaterials;
  final List<Map<String, dynamic>> selectedOtherMaterials;
  final void Function(List<Map<String, dynamic>>)
  onSelectedOtherMaterialsChanged;
  final VoidCallback onContinue;

  const OtherMaterialsPage({
    super.key,
    required this.otherMaterials,
    required this.selectedOtherMaterials,
    required this.onSelectedOtherMaterialsChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: _OtherMaterialsSelector(
          otherMaterials: otherMaterials,
          selectedOtherMaterials: selectedOtherMaterials,
          onSelectedOtherMaterialsChanged: onSelectedOtherMaterialsChanged,
          onContinue: onContinue,
        ),
      ),
    );
  }
}

class _OtherMaterialsSelector extends StatefulWidget {
  final List<InventoryItem> otherMaterials;
  final List<Map<String, dynamic>> selectedOtherMaterials;
  final void Function(List<Map<String, dynamic>>)
  onSelectedOtherMaterialsChanged;
  final VoidCallback onContinue;

  const _OtherMaterialsSelector({
    required this.otherMaterials,
    required this.selectedOtherMaterials,
    required this.onSelectedOtherMaterialsChanged,
    required this.onContinue,
  });

  @override
  State<_OtherMaterialsSelector> createState() =>
      _OtherMaterialsSelectorState();
}

class _OtherMaterialsSelectorState extends State<_OtherMaterialsSelector> {
  late List<Map<String, dynamic>> _selectedOtherMaterials;

  @override
  void initState() {
    super.initState();
    _selectedOtherMaterials = List<Map<String, dynamic>>.from(
      widget.selectedOtherMaterials,
    );
  }

  void _toggleMaterial(InventoryItem material, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedOtherMaterials.any((m) => m['name'] == material.name)) {
          _selectedOtherMaterials.add({
            'name': material.name,
            'quantity': null,
          });
        }
      } else {
        _selectedOtherMaterials.removeWhere((m) => m['name'] == material.name);
      }
      widget.onSelectedOtherMaterialsChanged(_selectedOtherMaterials);
    });
  }

  void _updateQuantity(String materialName, String value) {
    setState(() {
      final idx = _selectedOtherMaterials.indexWhere(
        (m) => m['name'] == materialName,
      );
      if (idx != -1) {
        final quantity = double.tryParse(value);
        if (quantity != null && quantity >= 0) {
          // Find the material to check available stock
          final material = widget.otherMaterials.firstWhere(
            (m) => m.name == materialName,
          );
          if (quantity <= material.quantity) {
            _selectedOtherMaterials[idx]['quantity'] = quantity;
          } else {
            // Show error for exceeding stock
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Cannot use more than ${material.quantity} ${material.unit} of ${material.name}',
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        } else {
          _selectedOtherMaterials[idx]['quantity'] = null;
        }
        widget.onSelectedOtherMaterialsChanged(_selectedOtherMaterials);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the other materials you used today.',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        ...widget.otherMaterials.map((material) {
          final isSelected = _selectedOtherMaterials.any(
            (m) => m['name'] == material.name,
          );
          return CheckboxListTile(
            value: isSelected,
            title: Text('${material.name} (Stock: ${material.quantity})'),
            onChanged: (checked) => _toggleMaterial(material, checked ?? false),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }).toList(),
        const SizedBox(height: 16),
        ..._selectedOtherMaterials.map((m) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(m['name'], style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'Qty',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: false,
                ),
                onChanged: (val) => _updateQuantity(m['name'], val),
                controller: TextEditingController(
                  text: m['quantity']?.toString() ?? '',
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
