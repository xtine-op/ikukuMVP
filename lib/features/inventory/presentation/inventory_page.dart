import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import '../../../shared/services/offline_data_service.dart';
import '../../../shared/providers/offline_data_provider.dart';
import '../data/inventory_item_model.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../../../shared/widgets/custom_dialog.dart';
import '../../../shared/widgets/status_feedback_widget.dart';
import '../../../shared/screens/status_feedback_screens.dart';
import '../../../shared/widgets/loading_button.dart';

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
    double price = 0.0;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('add_item_in_store'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('name_of_item'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? tr('enter_item_name') : null,
                    onSaved: (v) => name = v ?? '',
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('quantity'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) => v == null || int.tryParse(v) == null
                        ? tr('enter_item_quantity')
                        : null,
                    onSaved: (v) => quantity = int.tryParse(v ?? '0') ?? 0,
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<String>(
                    value: unit,
                    items: units
                        .map(
                          (u) =>
                              DropdownMenuItem(value: u, child: Text(u.tr())),
                        )
                        .toList(),
                    onChanged: (v) => unit = v ?? 'kg',
                    decoration: InputDecoration(
                      labelText: tr('unit'),
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
                    decoration: InputDecoration(
                      labelText: tr('price_per_unit'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => v == null || double.tryParse(v) == null
                        ? tr('enter_item_price')
                        : null,
                    onSaved: (v) => price = double.tryParse(v ?? '0') ?? 0.0,
                  ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: LoadingButton(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              formKey.currentState?.save();
                              try {
                                final item = InventoryItem.empty(user.id)
                                    .copyWith(
                                      name: name,
                                      category: category,
                                      quantity: quantity,
                                      unit: unit,
                                      addedOn: DateTime.now(),
                                      price: price,
                                    );
                                await SupabaseService().addInventoryItem(
                                  item.toJson(),
                                );

                                // Update dashboard for new feed items
                                if (category == 'feed') {
                                  final currentDashboardData =
                                      OfflineDataProvider
                                          .instance
                                          .dashboardData ??
                                      {};
                                  final updatedDashboardData = {
                                    ...currentDashboardData,
                                    'totalFeeds':
                                        (currentDashboardData['totalFeeds'] ??
                                            0) +
                                        quantity,
                                  };
                                  await OfflineDataService.instance
                                      .cacheUserDashboard(
                                        user.id,
                                        updatedDashboardData,
                                      );
                                  await OfflineDataProvider.instance
                                      .loadDashboardData(forceRefresh: true);
                                }

                                if (mounted) {
                                  // Close dialog first
                                  Navigator.pop(context);
                                  // Show success screen via showDialog
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (ctx) => Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      child: StoreSuccessScreen(
                                        onViewStore: () {
                                          Navigator.pop(ctx);
                                          fetchItems();
                                        },
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  Navigator.pop(context);
                                  // Show error screen via showDialog
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (ctx) => Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      child: StoreErrorScreen(
                                        onTryAgain: () {
                                          Navigator.pop(ctx);
                                          _showAddItemDialog();
                                        },
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          type: LoadingButtonType.elevated,
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
                          child: Text(tr('add_item')),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
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
                          child: Text(
                            tr('cancel'),
                            style: const TextStyle(color: CustomColors.primary),
                          ),
                        ),
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

  void _showEditItemDialog(InventoryItem item) async {
    // Capture the page context to avoid using the dialog's inner context
    // (using the inner dialog context after popping can prevent new dialogs
    // from showing). Use `pageContext` when presenting the status dialogs.
    final pageContext = context;
    final formKey = GlobalKey<FormState>();
    String name = item.name;
    String category = item.category;
    int quantity = item.quantity;
    String unit = item.unit;
    double price = item.price;
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
                  Text(
                    tr('edit_farm_store_item'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(
                      labelText: tr('item_name'),
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
                    items: [
                      DropdownMenuItem(value: 'feed', child: Text(tr('feeds'))),
                      DropdownMenuItem(
                        value: 'vaccine',
                        child: Text(tr('vaccines')),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text(tr('others')),
                      ),
                    ],
                    onChanged: (v) => category = v ?? 'feed',
                    decoration: InputDecoration(
                      labelText: tr('category'),
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
                      labelText: tr('quantity'),
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
                    value: ['kg', 'g', 'litres', 'pcs'].contains(unit)
                        ? unit
                        : 'kg',
                    items: ['kg', 'g', 'litres', 'pcs']
                        .map(
                          (u) =>
                              DropdownMenuItem(value: u, child: Text(u.tr())),
                        )
                        .toList(),
                    onChanged: (v) => unit = v ?? 'kg',
                    decoration: InputDecoration(
                      labelText: tr('unit'),
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
                    initialValue: price.toStringAsFixed(2),
                    decoration: InputDecoration(
                      labelText: tr('price_per_unit'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green, width: 1.2),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => v == null || double.tryParse(v) == null
                        ? 'Enter a number'
                        : null,
                    onSaved: (v) => price = double.tryParse(v ?? '0') ?? 0.0,
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
                        child: Text(
                          tr('cancel'),
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            try {
                              final updatedItem = item.copyWith(
                                name: name,
                                category: category,
                                quantity: quantity,
                                unit: unit,
                                price: price,
                              );
                              await SupabaseService().updateInventoryItem(
                                updatedItem.toJson(),
                              );

                              // Update dashboard for feed items
                              if (category == 'feed') {
                                final user =
                                    Supabase.instance.client.auth.currentUser;
                                if (user != null) {
                                  final currentDashboardData =
                                      OfflineDataProvider
                                          .instance
                                          .dashboardData ??
                                      {};
                                  final quantityChange =
                                      quantity - item.quantity;
                                  final updatedDashboardData = {
                                    ...currentDashboardData,
                                    'totalFeeds':
                                        (currentDashboardData['totalFeeds'] ??
                                            0) +
                                        quantityChange,
                                  };
                                  await OfflineDataService.instance
                                      .cacheUserDashboard(
                                        user.id,
                                        updatedDashboardData,
                                      );
                                  await OfflineDataProvider.instance
                                      .loadDashboardData(forceRefresh: true);
                                }
                              }

                              if (mounted) {
                                // Close dialog first
                                Navigator.pop(context);
                                // Show success screen via showDialog using the
                                // outer page context so the new dialog is shown
                                // on the page navigator (not the popped dialog
                                // context).
                                showDialog(
                                  context: pageContext,
                                  barrierDismissible: false,
                                  builder: (ctx) => Dialog(
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    child: StoreSuccessScreen(
                                      onViewStore: () {
                                        Navigator.pop(ctx);
                                        fetchItems();
                                      },
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                Navigator.pop(context);
                                // Show error screen using the page context
                                showDialog(
                                  context: pageContext,
                                  barrierDismissible: false,
                                  builder: (ctx) => Dialog(
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    child: StoreErrorScreen(
                                      onTryAgain: () {
                                        Navigator.pop(ctx);
                                        // Reopen the edit dialog
                                      },
                                    ),
                                  ),
                                );
                              }
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
                        child: Text(tr('save')),
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
    // Use parent page context for showing status dialogs after closing
    // this add-amount dialog.
    final pageContext = context;
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
                  tr('add_amount_to', namedArgs: {'item': item.name}),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: tr('amount_to_add'),
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
                      child: Text(
                        tr('cancel'),
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                    LoadingButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          final updatedItem = item.copyWith(
                            quantity: item.quantity + addAmount,
                          );
                          await SupabaseService().updateInventoryItem(
                            updatedItem.toJson(),
                          );

                          // Update dashboard for feed items
                          if (item.category == 'feed') {
                            final user =
                                Supabase.instance.client.auth.currentUser;
                            if (user != null) {
                              final currentDashboardData =
                                  OfflineDataProvider.instance.dashboardData ??
                                  {};
                              final updatedDashboardData = {
                                ...currentDashboardData,
                                'totalFeeds':
                                    (currentDashboardData['totalFeeds'] ?? 0) +
                                    addAmount,
                              };
                              await OfflineDataService.instance
                                  .cacheUserDashboard(
                                    user.id,
                                    updatedDashboardData,
                                  );
                              await OfflineDataProvider.instance
                                  .loadDashboardData(forceRefresh: true);
                            }
                          }

                          if (mounted) {
                            Navigator.pop(context);
                            fetchItems();
                            showCustomDialog(
                              context: pageContext,
                              title: tr('success'),
                              message: tr('quantity_updated'),
                              isSuccess: true,
                              onOkPressed: () => Navigator.pop(pageContext),
                            );
                          }
                        }
                      },
                      type: LoadingButtonType.elevated,
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
                      child: Text(tr('add')),
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
      heading = tr('feeds_available_inventory');
      tip = tr('tip_adjust_feed');
      tipIcon = 'assets/icons/tip-chicken.png';
    } else if (widget.category == 'vaccine') {
      heading = tr('vaccines_available_inventory');
      tip = tr('tip_adjust_vaccine');
      tipIcon = 'assets/icons/tip-chicken.png';
    } else {
      heading = tr('items_available_inventory');
      tip = tr('tip_adjust_item');
      tipIcon = 'assets/icons/tip-chicken.png';
    }
    return WillPopScope(
      onWillPop: () async {
        context.go('/inventory-categories');
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => context.go('/inventory-categories'),
          ),
          title: const Text('', style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
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
                      Center(
                        child: Text(
                          tr('no_items_in_store_yet'),
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            final item = items[i];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x1400681D),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 18,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: CustomColors.text,
                                        ),
                                      ),
                                      Text(
                                        '${item.quantity}${item.unit}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: CustomColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${item.price} Ksh',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: CustomColors.secondary,
                                            ),
                                            tooltip: tr('add_amount'),
                                            onPressed: () async {
                                              int?
                                              addAmount = await showDialog<int>(
                                                context: context,
                                                builder: (context) {
                                                  int value = 0;
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            24,
                                                          ),
                                                    ),
                                                    title: Text(
                                                      tr(
                                                        'add_to',
                                                        namedArgs: {
                                                          'item': item.name,
                                                        },
                                                      ),
                                                    ),
                                                    content: TextFormField(
                                                      autofocus: true,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                        labelText: tr(
                                                          'amount_to_add',
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        border: OutlineInputBorder(
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
                                                      ),
                                                      onChanged: (v) => value =
                                                          int.tryParse(v) ?? 0,
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              context,
                                                            ),
                                                        child: Text(
                                                          tr('cancel'),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              CustomColors
                                                                  .primary,
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
                                                        child: Text(tr('add')),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              if (addAmount != null &&
                                                  addAmount > 0) {
                                                final updatedItem = item
                                                    .copyWith(
                                                      quantity:
                                                          item.quantity +
                                                          addAmount,
                                                    );
                                                await SupabaseService()
                                                    .updateInventoryItem(
                                                      updatedItem.toJson(),
                                                    );

                                                // Update dashboard for feed items
                                                if (item.category == 'feed') {
                                                  final user = Supabase
                                                      .instance
                                                      .client
                                                      .auth
                                                      .currentUser;
                                                  if (user != null) {
                                                    final currentDashboardData =
                                                        OfflineDataProvider
                                                            .instance
                                                            .dashboardData ??
                                                        {};
                                                    final updatedDashboardData = {
                                                      ...currentDashboardData,
                                                      'totalFeeds':
                                                          (currentDashboardData['totalFeeds'] ??
                                                              0) +
                                                          addAmount,
                                                    };
                                                    await OfflineDataService
                                                        .instance
                                                        .cacheUserDashboard(
                                                          user.id,
                                                          updatedDashboardData,
                                                        );
                                                    await OfflineDataProvider
                                                        .instance
                                                        .loadDashboardData(
                                                          forceRefresh: true,
                                                        );
                                                  }
                                                }

                                                if (mounted) fetchItems();
                                              }
                                            },
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                _showEditItemDialog(item),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  CustomColors.primary,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            child: Text(tr('edit')),
                                          ),
                                        ],
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
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
