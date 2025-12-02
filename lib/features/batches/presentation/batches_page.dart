import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import '../../../shared/providers/offline_data_provider.dart';

import '../data/batch_model.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

class BatchesPage extends StatefulWidget {
  final bool fromReportsPage;

  const BatchesPage({super.key, this.fromReportsPage = false});

  @override
  State<BatchesPage> createState() => _BatchesPageState();
}

class _BatchesPageState extends State<BatchesPage> {
  List<Batch> batches = [];
  bool loading = true;
  bool _hasShownAddReportDialog =
      false; // Track if dialog was shown in this session

  @override
  void initState() {
    super.initState();
    fetchBatches();
  }

  Future<void> fetchBatches() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    // Load batches with offline fallback
    await OfflineDataProvider.instance.loadBatches();
    setState(() {
      batches = OfflineDataProvider.instance.batches;
      loading = false;
    });
  }

  void _showAddReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFF7F8FA),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Text(
            tr('add_report_q'),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Text(
            tr('add_report_desc'),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CustomColors.primary,
                    side: BorderSide(color: CustomColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(tr('no')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/report-entry');
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
                      child: Text(tr('yes')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddBatchDialog() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    final formKey = GlobalKey<FormState>();
    String name = '';
    String birdType = 'broiler';
    int ageInDays = 0;
    int totalChickens = 0;
    double pricePerBird = 0;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Color(0xFFF7F8FA),
        title: Text(tr('add_batch')),
        content: SizedBox(
          width: 500, // Increase dialog width for better UI
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('batch_name'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => name = v ?? '',
                  ),
                  SizedBox(height: 18),
                  DropdownButtonFormField<String>(
                    value: birdType,
                    items: [
                      DropdownMenuItem(
                        value: 'broiler',
                        child: Text(tr('broiler')),
                      ),
                      DropdownMenuItem(
                        value: 'kienyeji',
                        child: Text(tr('kienyeji')),
                      ),
                      DropdownMenuItem(
                        value: 'layer',
                        child: Text(tr('layer')),
                      ),
                    ],
                    onChanged: (v) => birdType = v ?? 'broiler',
                    decoration: InputDecoration(
                      labelText: tr('bird_type'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('age_in_days'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) => v == null || int.tryParse(v) == null
                        ? 'Enter a number'
                        : null,
                    onSaved: (v) => ageInDays = int.tryParse(v ?? '0') ?? 0,
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('total_chickens'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) => v == null || int.tryParse(v) == null
                        ? 'Enter a number'
                        : null,
                    onSaved: (v) => totalChickens = int.tryParse(v ?? '0') ?? 0,
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: tr('price_per_bird'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => v == null || double.tryParse(v) == null
                        ? 'Enter a valid price'
                        : null,
                    onSaved: (v) =>
                        pricePerBird = double.tryParse(v ?? '0') ?? 0,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CustomColors.primary,
                      side: BorderSide(color: CustomColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(tr('cancel')),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        formKey.currentState?.save();
                        final batch = Batch.empty(user.id).copyWith(
                          name: name,
                          birdType: birdType,
                          ageInDays: ageInDays,
                          totalChickens: totalChickens,
                          pricePerBird: pricePerBird,
                          createdAt: DateTime.now(),
                        );
                        await OfflineDataProvider.instance.addBatch(
                          batch.toJson(),
                        );
                        if (mounted) {
                          Navigator.pop(context);
                          fetchBatches();
                          // Show popup asking if user wants to add a report
                          // Only if they came from the reports page and haven't shown dialog yet
                          if (widget.fromReportsPage &&
                              !_hasShownAddReportDialog) {
                            setState(() {
                              _hasShownAddReportDialog = true;
                            });
                            _showAddReportDialog();
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primary,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      tr('add_batch'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditBatchDialog(Batch batch) async {
    final formKey = GlobalKey<FormState>();
    String name = batch.name;
    double pricePerBird = batch.pricePerBird;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFF7F8FA),
        title: Text(tr('edit_batch')),
        content: SizedBox(
          width: 500, // Set consistent width for better UI
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Read-only batch information
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Batch Information',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Type: ${batch.birdType.toUpperCase()}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Current Age: ${batch.currentAgeInDays} days',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Total Birds: ${batch.totalChickens}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Editable fields
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(
                      labelText: tr('batch_name'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => name = v ?? '',
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: pricePerBird.toString(),
                    decoration: InputDecoration(
                      labelText: tr('price_per_bird'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) => v == null || double.tryParse(v) == null
                        ? 'Enter a valid price'
                        : null,
                    onSaved: (v) =>
                        pricePerBird = double.tryParse(v ?? '0') ?? 0,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          // Save button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  final updatedBatch = batch.copyWith(
                    name: name,
                    pricePerBird: pricePerBird,
                  );
                  await SupabaseService().updateBatch(updatedBatch.toJson());
                  if (mounted) {
                    Navigator.pop(context);
                    fetchBatches();
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
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
                    tr('save'),
                    style: const TextStyle(color: CustomColors.text),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12), // Space between buttons
          // Cancel button below Save button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: CustomColors.primary,
                side: BorderSide(color: CustomColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(tr('cancel')),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = !loading && batches.isEmpty;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text('batches'.tr()),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : isEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Manage Batches',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/animal-chicken.svg',
                          width: 28,
                          height: 28,
                          package: null,
                          errorBuilder: (c, e, s) =>
                              const Icon(Icons.info_outline),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Tip: A batch is a group of chicken, obtained at the same time',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'My Batches',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/amico.png',
                            width: 140,
                            height: 140,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'no_batches_yet'.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'batches_empty_hint'.tr(),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: CustomColors.buttonGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add, color: CustomColors.text),
                                label: Text(
                                  'CREATE A BATCH',
                                  style: TextStyle(
                                    color: CustomColors.text,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                onPressed: _showAddBatchDialog,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  foregroundColor: CustomColors.text,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: batches.length,
              itemBuilder: (context, i) {
                final batch = batches[i];
                return ListTile(
                  title: Text(batch.name),
                  subtitle: Text(
                    '${'bird_type'.tr()}: ' +
                        (batch.birdType == 'broiler'
                            ? 'broiler'.tr()
                            : batch.birdType == 'layer'
                            ? 'layer'.tr()
                            : batch.birdType == 'kienyeji'
                            ? 'kienyeji'.tr()
                            : 'unknown_type'.tr()) +
                        ', ${'chickens'.tr()}: ${batch.totalChickens}' +
                        ', Age: ${batch.currentAgeInDays} days',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditBatchDialog(batch);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              backgroundColor: Color(0xFFF7F8FA),
                              title: const Text('Delete Batch'),
                              content: Text(
                                'Are you sure you want to delete "${batch.name}"?',
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: CustomColors.primary,
                                    side: BorderSide(
                                      color: CustomColors.primary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await SupabaseService().deleteBatch(batch.id);
                            fetchBatches();
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    context.go('/report-entry');
                  },
                );
              },
            ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      floatingActionButton: isEmpty
          ? null
          : Container(
              decoration: BoxDecoration(
                gradient: CustomColors.buttonGradient,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FloatingActionButton(
                onPressed: _showAddBatchDialog,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.add, color: CustomColors.text),
              ),
            ),
    );
  }
}
