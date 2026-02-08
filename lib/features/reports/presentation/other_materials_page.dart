import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';

class OtherMaterialsPage extends StatelessWidget {
  final List<InventoryItem> otherMaterials;
  final List<Map<String, dynamic>> selectedOtherMaterials;
  final void Function(List<Map<String, dynamic>>)
  onSelectedOtherMaterialsChanged;
  final VoidCallback onContinue;
  final VoidCallback? onDone;

  const OtherMaterialsPage({
    super.key,
    required this.otherMaterials,
    required this.selectedOtherMaterials,
    required this.onSelectedOtherMaterialsChanged,
    required this.onContinue,
    this.onDone,
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
          onDone: onDone,
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
  final VoidCallback? onDone;

  const _OtherMaterialsSelector({
    required this.otherMaterials,
    required this.selectedOtherMaterials,
    required this.onSelectedOtherMaterialsChanged,
    required this.onContinue,
    this.onDone,
  });

  @override
  State<_OtherMaterialsSelector> createState() =>
      _OtherMaterialsSelectorState();
}

class _OtherMaterialsSelectorState extends State<_OtherMaterialsSelector> {
  late List<Map<String, dynamic>> _selectedOtherMaterials;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _selectedOtherMaterials = List<Map<String, dynamic>>.from(
      widget.selectedOtherMaterials,
    );
    for (final m in _selectedOtherMaterials) {
      final name = m['name'];
      _controllers[name] = TextEditingController(
        text: m['quantity']?.toString() ?? '',
      );
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _toggleMaterial(InventoryItem material, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedOtherMaterials.any((m) => m['name'] == material.name)) {
          _selectedOtherMaterials.add({
            'name': material.name,
            'quantity': null,
          });
          _controllers[material.name] = TextEditingController();
        }
      } else {
        _selectedOtherMaterials.removeWhere((m) => m['name'] == material.name);
        _controllers[material.name]?.dispose();
        _controllers.remove(material.name);
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
            _controllers[materialName]?.text = value;
          } else {
            // Show error for exceeding stock
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'cannot_use_more_than_other_materials'.tr(
                    namedArgs: {
                      'quantity': material.quantity.toString(),
                      'unit': material.unit,
                      'item': material.name,
                    },
                  ),
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
        Text(
          'select_other_materials_today'.tr(),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        ...widget.otherMaterials.map((material) {
          final isSelected = _selectedOtherMaterials.any(
            (m) => m['name'] == material.name,
          );
          return CheckboxListTile(
            value: isSelected,
            title: Text(
              '${material.name} (${"stock".tr()}: ${material.quantity})',
            ),
            onChanged: (checked) => _toggleMaterial(material, checked ?? false),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),
        const SizedBox(height: 16),
        ..._selectedOtherMaterials.map((m) {
          final name = m['name'];
          // Find the material to get its unit
          final material = widget.otherMaterials.firstWhere(
            (material) => material.name == name,
          );
          final unit = material.unit;

          _controllers[name] ??= TextEditingController(
            text: m['quantity']?.toString() ?? '',
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'How much $name did you use in ${unit.tr()}?',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: false,
                  suffixText: unit.tr(),
                ),
                onChanged: (val) => _updateQuantity(name, val),
                controller: _controllers[name],
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
        const SizedBox(height: 24),
        if (widget.onDone != null) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onDone,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'DONE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ] else ...[
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
      ],
    );
  }
}
