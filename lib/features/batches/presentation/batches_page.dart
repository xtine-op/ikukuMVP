import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
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
    final data = await SupabaseService().fetchBatches(user.id);
    setState(() {
      batches = data.map((e) => Batch.fromJson(e)).toList();
      loading = false;
    });
  }

  void _showAddReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFFF7F8FA),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Text(
            'Add Report?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        content: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Text(
            'Do you want to add a report for this batch?',
            style: TextStyle(fontSize: 16),
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
                  child: const Text('No'),
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
                      child: const Text('Yes'),
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
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Color(0xFFF7F8FA),
        title: const Text('Add Batch'),
        content: SizedBox(
          width: 400, // Make dialog a little wider
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Batch Name',
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
                    items: const [
                      DropdownMenuItem(
                        value: 'broiler',
                        child: Text('Broiler'),
                      ),
                      DropdownMenuItem(
                        value: 'kienyeji',
                        child: Text('Kienyeji'),
                      ),
                      DropdownMenuItem(value: 'layer', child: Text('Layer')),
                    ],
                    onChanged: (v) => birdType = v ?? 'broiler',
                    decoration: InputDecoration(
                      labelText: 'Bird Type',
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
                      labelText: 'Age in Days',
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
                      labelText: 'Total Chickens',
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
                ],
              ),
            ),
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
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      final batch = Batch.empty(user.id).copyWith(
                        name: name,
                        birdType: birdType,
                        ageInDays: ageInDays,
                        totalChickens: totalChickens,
                        createdAt: DateTime.now(),
                      );
                      await SupabaseService().addBatch(batch.toJson());
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
                      child: const Text('Add Batch'),
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
    String birdType = batch.birdType;
    int ageInDays = batch.ageInDays;
    int totalChickens = batch.totalChickens;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Color(0xFFF7F8FA),
        title: const Text('Edit Batch'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(
                    labelText: 'Batch Name',
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
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => name = v ?? '',
                ),
                SizedBox(height: 18),
                DropdownButtonFormField<String>(
                  value: birdType,
                  items: const [
                    DropdownMenuItem(value: 'broiler', child: Text('Broiler')),
                    DropdownMenuItem(
                      value: 'kienyeji',
                      child: Text('Kienyeji'),
                    ),
                    DropdownMenuItem(value: 'layer', child: Text('Layer')),
                  ],
                  onChanged: (v) => birdType = v ?? 'broiler',
                  decoration: InputDecoration(
                    labelText: 'Bird Type',
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
                  initialValue: ageInDays.toString(),
                  decoration: InputDecoration(
                    labelText: 'Age in Days',
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
                  initialValue: totalChickens.toString(),
                  decoration: InputDecoration(
                    labelText: 'Total Chickens',
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
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: CustomColors.primary,
              side: BorderSide(color: CustomColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                final updatedBatch = batch.copyWith(
                  name: name,
                  birdType: birdType,
                  ageInDays: ageInDays,
                  totalChickens: totalChickens,
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
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: CustomColors.buttonGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minHeight: 48),
                child: const Text('Save'),
              ),
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
          onPressed: () => context.go('/'),
        ),
        title: const Text('Batches'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Coming soon.')));
            },
          ),
        ],
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
                          const Text(
                            'You have no batches yet',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'The batches you create will appear here',
                            style: TextStyle(
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
                    'Type: ${batch.birdType}, Chickens: ${batch.totalChickens}',
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
                                  child: const Text('Delete'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
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
