import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';
import '../data/batch_model.dart';

class BatchesPage extends StatefulWidget {
  const BatchesPage({super.key});

  @override
  State<BatchesPage> createState() => _BatchesPageState();
}

class _BatchesPageState extends State<BatchesPage> {
  List<Batch> batches = [];
  bool loading = true;

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
        title: const Text('Add Batch'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Batch Name'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => name = v ?? '',
                ),
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
                  decoration: const InputDecoration(labelText: 'Bird Type'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Age in Days'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'Enter a number'
                      : null,
                  onSaved: (v) => ageInDays = int.tryParse(v ?? '0') ?? 0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Total Chickens',
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
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

  void _showEditBatchDialog(Batch batch) async {
    final formKey = GlobalKey<FormState>();
    String name = batch.name;
    String birdType = batch.birdType;
    int ageInDays = batch.ageInDays;
    int totalChickens = batch.totalChickens;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Batch'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: 'Batch Name'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => name = v ?? '',
                ),
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
                  decoration: const InputDecoration(labelText: 'Bird Type'),
                ),
                TextFormField(
                  initialValue: ageInDays.toString(),
                  decoration: const InputDecoration(labelText: 'Age in Days'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'Enter a number'
                      : null,
                  onSaved: (v) => ageInDays = int.tryParse(v ?? '0') ?? 0,
                ),
                TextFormField(
                  initialValue: totalChickens.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Total Chickens',
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
          TextButton(
            onPressed: () => Navigator.pop(context),
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Add Chick Batch'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
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
                              title: const Text('Delete Batch'),
                              content: Text(
                                'Are you sure you want to delete "${batch.name}"?',
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
                            await SupabaseService().deleteBatch(batch.id);
                            fetchBatches();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBatchDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
