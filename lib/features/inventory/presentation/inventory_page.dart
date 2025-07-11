import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import '../data/inventory_item_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<InventoryItem> items = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    final data = await SupabaseService().fetchInventory(user.id);
    setState(() {
      items = data.map((e) => InventoryItem.fromJson(e)).toList();
      loading = false;
    });
  }

  void _showAddItemDialog() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    final formKey = GlobalKey<FormState>();
    String name = '';
    String category = 'feed';
    int quantity = 0;
    String unit = 'kg';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Farm Store Item'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => name = v ?? '',
                ),
                DropdownButtonFormField<String>(
                  value: category,
                  items: const [
                    DropdownMenuItem(value: 'feed', child: Text('Feed')),
                    DropdownMenuItem(value: 'vaccine', child: Text('Vaccine')),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                  ],
                  onChanged: (v) => category = v ?? 'feed',
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'Enter a number'
                      : null,
                  onSaved: (v) => quantity = int.tryParse(v ?? '0') ?? 0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Unit'),
                  initialValue: unit,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => unit = v ?? 'kg',
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                final item = InventoryItem.empty(user.id).copyWith(
                  name: name,
                  category: category,
                  quantity: quantity,
                  unit: unit,
                  addedOn: DateTime.now(),
                );
                await SupabaseService().addInventoryItem(item.toJson());
                if (mounted) {
                  Navigator.pop(context);
                  fetchItems();
                }
              }
            },
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
                child: const Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditItemDialog(InventoryItem item) async {
    final formKey = GlobalKey<FormState>();
    String name = item.name;
    String category = item.category;
    int quantity = item.quantity;
    String unit = item.unit;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Farm Store Item'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => name = v ?? '',
                ),
                DropdownButtonFormField<String>(
                  value: category,
                  items: const [
                    DropdownMenuItem(value: 'feed', child: Text('Feed')),
                    DropdownMenuItem(value: 'vaccine', child: Text('Vaccine')),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                  ],
                  onChanged: (v) => category = v ?? 'feed',
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextFormField(
                  initialValue: quantity.toString(),
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'Enter a number'
                      : null,
                  onSaved: (v) => quantity = int.tryParse(v ?? '0') ?? 0,
                ),
                TextFormField(
                  initialValue: unit,
                  decoration: const InputDecoration(labelText: 'Unit'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => unit = v ?? 'kg',
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                final updatedItem = item.copyWith(
                  name: name,
                  category: category,
                  quantity: quantity,
                  unit: unit,
                );
                await SupabaseService().updateInventoryItem(
                  updatedItem.toJson(),
                );
                if (mounted) {
                  Navigator.pop(context);
                  fetchItems();
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Farm Store'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final item = items[i];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    'Category: ${item.category}, Qty: ${item.quantity} ${item.unit}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditItemDialog(item);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Item'),
                              content: Text(
                                'Are you sure you want to delete "${item.name}"?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await SupabaseService().deleteInventoryItem(
                              item.id,
                            );
                            fetchItems();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
