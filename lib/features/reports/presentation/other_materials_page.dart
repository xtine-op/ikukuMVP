import 'package:flutter/material.dart';
import '../../inventory/data/inventory_item_model.dart';

class OtherMaterialsPage extends StatelessWidget {
  final List<InventoryItem> otherMaterials;
  final Map<InventoryItem, double> otherMaterialsUsed;
  final void Function(InventoryItem, String) onMaterialUsedChanged;
  final VoidCallback onContinue;

  const OtherMaterialsPage({
    super.key,
    required this.otherMaterials,
    required this.otherMaterialsUsed,
    required this.onMaterialUsedChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Other materials used today:'),
          ...otherMaterials.map(
            (item) => Row(
              children: [
                Expanded(child: Text('${item.name} (Stock: ${item.quantity})')),
                SizedBox(
                  width: 80,
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Used'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => onMaterialUsedChanged(item, v),
                  ),
                ),
              ],
            ),
          ),
          if (otherMaterials.any(
            (item) => (otherMaterialsUsed[item] ?? 0) > item.quantity,
          ))
            const Text(
              'Cannot use more than available in store.',
              style: TextStyle(color: Colors.red),
            ),
          const Spacer(),
          ElevatedButton(onPressed: onContinue, child: const Text('Continue')),
        ],
      ),
    );
  }
}
