import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import '../data/inventory_item_model.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

class InventoryPage extends StatefulWidget {
  final String category;
  const InventoryPage({super.key, required this.category});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<InventoryItem> items = [];
  bool loading = true;
  // Set to a valid tab index (e.g., 0 for Home, or 1 for Batches if you want Batches active)
  int _selectedIndex = 0;

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
      items = data
          .map((e) => InventoryItem.fromJson(e))
          .where((item) => item.category == widget.category)
          .toList();
      loading = false;
    });
  }

  void _onNavBarTapped(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/batches');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  void _showAddItemDialog() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    final formKey = GlobalKey<FormState>();
    String name = '';
    String category = widget.category;
    int quantity = 0;
    String unit = 'kg';
    List<String> units = ['kg', 'g', 'litres', 'pcs'];
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFF7F8FA),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add item in store',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name of item',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.green, width: 1.2),
                    ),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => name = v ?? '',
                ),
                const SizedBox(height: 18),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.green, width: 1.2),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'Enter a number'
                      : null,
                  onSaved: (v) => quantity = int.tryParse(v ?? '0') ?? 0,
                ),
                const SizedBox(height: 18),
                DropdownButtonFormField<String>(
                  value: unit,
                  items: units
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (v) => unit = v ?? 'kg',
                  decoration: InputDecoration(
                    labelText: 'Unit',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.green, width: 1.2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: CustomColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: CustomColors.primary),
                      ),
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
                          await SupabaseService().addInventoryItem(
                            item.toJson(),
                          );
                          if (mounted) {
                            Navigator.pop(context);
                            fetchItems();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Add Item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFF7F8FA),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Edit Farm Store Item',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(
                      labelText: 'Item Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => name = v ?? '',
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<String>(
                    value: category,
                    items: const [
                      DropdownMenuItem(value: 'feed', child: Text('Feed')),
                      DropdownMenuItem(
                        value: 'vaccine',
                        child: Text('Vaccine'),
                      ),
                      DropdownMenuItem(value: 'other', child: Text('Other')),
                    ],
                    onChanged: (v) => category = v ?? 'feed',
                    decoration: InputDecoration(
                      labelText: 'Category',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: quantity.toString(),
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) => v == null || int.tryParse(v) == null
                        ? 'Enter a number'
                        : null,
                    onSaved: (v) => quantity = int.tryParse(v ?? '0') ?? 0,
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: unit,
                    decoration: InputDecoration(
                      labelText: 'Unit',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => unit = v ?? 'kg',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.green),
                        ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddAmountDialog(InventoryItem item) async {
    final formKey = GlobalKey<FormState>();
    int addAmount = 0;
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFF7F8FA),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add amount to ${item.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount to add',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.green, width: 1.2),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'Enter a number'
                      : null,
                  onSaved: (v) => addAmount = int.tryParse(v ?? '0') ?? 0,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          final updatedItem = item.copyWith(
                            quantity: item.quantity + addAmount,
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String heading;
    String tip;
    String tipIcon;
    if (widget.category == 'feed') {
      heading = 'Feeds available in your inventory';
      tip =
          'Tip: You can adjust feed amounts when recording daily farm reports .';
      tipIcon = 'assets/icons/tip-chicken.png';
    } else if (widget.category == 'vaccine') {
      heading = 'Vaccines available in your inventory';
      tip =
          'Tip: You can adjust vaccine amounts when recording daily farm reports .';
      tipIcon = 'assets/icons/tip-chicken.png';
    } else {
      heading = 'Items available in your inventory';
      tip =
          'Tip: You can adjust item amounts when recording daily farm reports .';
      tipIcon = 'assets/icons/tip-chicken.png';
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.go('/inventory-categories'),
        ),
        title: const Text('', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(tipIcon, width: 48, height: 48),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (items.isEmpty)
                    const Center(
                      child: Text(
                        'No items in store yet',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, i) {
                          final item = items[i];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 18,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${item.quantity}${item.unit}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: CustomColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: CustomColors.secondary,
                                      ),
                                      tooltip: 'Add amount',
                                      onPressed: () async {
                                        int? addAmount = await showDialog<int>(
                                          context: context,
                                          builder: (context) {
                                            int value = 0;
                                            return AlertDialog(
                                              backgroundColor: Colors
                                                  .white, // Change background to white
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              title: Text(
                                                'Add to ${item.name}',
                                              ),
                                              content: TextFormField(
                                                autofocus: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Amount to add',
                                                  filled: true,
                                                  fillColor: Colors
                                                      .white, // Ensure input is white
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          CustomColors.primary,
                                                      width: 1.2,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              16,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: CustomColors
                                                              .primary,
                                                          width: 1.2,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              16,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: CustomColors
                                                              .primary,
                                                          width: 1.8,
                                                        ),
                                                      ),
                                                ),
                                                onChanged: (v) => value =
                                                    int.tryParse(v) ?? 0,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        CustomColors.primary,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 24,
                                                          vertical: 12,
                                                        ),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                        context,
                                                        value,
                                                      ),
                                                  child: const Text('Add'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        if (addAmount != null &&
                                            addAmount > 0) {
                                          final updatedItem = item.copyWith(
                                            quantity: item.quantity + addAmount,
                                          );
                                          await SupabaseService()
                                              .updateInventoryItem(
                                                updatedItem.toJson(),
                                              );
                                          if (mounted) fetchItems();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: CustomColors.buttonGradient,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FloatingActionButton(
          onPressed: _showAddItemDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

String _categoryLabel(String category) {
  switch (category) {
    case 'feed':
      return 'Feeds';
    case 'vaccine':
      return 'Vaccines';
    case 'other':
      return 'Others';
    default:
      return category;
  }
}
