import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/services/supabase_service.dart';
import '../../batches/data/batch_model.dart';
import '../../inventory/data/inventory_item_model.dart';
import 'select_batch_page.dart';
import 'chicken_reduction_page.dart';
import 'egg_production_page.dart';
import 'feeds_page.dart';
import 'vaccines_page.dart';
import 'other_materials_page.dart';
import 'additional_notes_page.dart';
import 'review_and_save_page.dart';

/// Multi-step, conditional farm report entry flow per Updated_Farm_Report_Entry_Flow.md
class FarmReportEntryPage extends StatefulWidget {
  const FarmReportEntryPage({super.key});

  @override
  State<FarmReportEntryPage> createState() => _FarmReportEntryPageState();
}

class _FarmReportEntryPageState extends State<FarmReportEntryPage> {
  // Step tracking
  int step = 0;
  PageController? _pageController;

  // Data for each step
  List<Batch> batches = [];
  Batch? selectedBatch;
  String? chickenReduction; // yes/no
  String? reductionReason; // curled/stolen/death
  int? reductionCount;
  bool? collectedEggs; // only for layers/kienyeji
  int? eggsCollected;
  bool? gradeEggs;
  int? bigEggs;
  int? deformedEggs;
  int? brokenEggs;
  InventoryItem? selectedFeed;
  double? feedAmount;
  InventoryItem? selectedVaccine;
  double? vaccineAmount;
  Map<InventoryItem, double> otherMaterialsUsed = {};
  String? notes;

  // Inventory
  List<InventoryItem> feeds = [];
  List<InventoryItem> vaccines = [];
  List<InventoryItem> otherMaterials = [];

  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: step);
    _fetchInitialData();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialData() async {
    setState(() => loading = true);
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() {
        loading = false;
        error = 'Not signed in.';
      });
      return;
    }
    // Fetch batches and inventory
    final batchListRaw = await SupabaseService().fetchBatches(user.id);
    final inventoryRaw = await SupabaseService().fetchInventory(user.id);
    setState(() {
      batches = batchListRaw.map((e) => Batch.fromJson(e)).toList();
      final inventoryItems = inventoryRaw
          .map((e) => InventoryItem.fromJson(e))
          .toList();
      feeds = inventoryItems.where((i) => i.category == 'feed').toList();
      vaccines = inventoryItems.where((i) => i.category == 'vaccine').toList();
      otherMaterials = inventoryItems
          .where((i) => i.category == 'other')
          .toList();
      loading = false;
    });
  }

  void _nextStep() {
    setState(() => step++);
    _pageController?.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _prevStep() {
    if (step > 0) setState(() => step--);
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (error != null) return Scaffold(body: Center(child: Text(error!)));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Farm Report Entry'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            step = index;
          });
        },
        children: _buildPages(),
      ),
    );
  }

  List<Widget> _buildPages() {
    return [
      // Page 1: Select Batch
      SelectBatchPage(
        batches: batches,
        selectedBatch: selectedBatch,
        onBatchSelected: (batch) => setState(() => selectedBatch = batch),
        onContinue: _nextStep,
      ),
      // Page 2: Chicken Reduction
      ChickenReductionPage(
        chickenReduction: chickenReduction,
        onReductionChanged: (v) => setState(() => chickenReduction = v),
        reductionReason: reductionReason,
        onReasonChanged: (v) => setState(() => reductionReason = v),
        reductionCount: reductionCount,
        onCountChanged: (v) => setState(() => reductionCount = int.tryParse(v)),
        onContinue: _nextStep,
      ),
      // Page 3: Egg Production
      EggProductionPage(
        selectedBatch: selectedBatch,
        collectedEggs: collectedEggs,
        onCollectedEggsChanged: (v) => setState(() => collectedEggs = v),
        eggsCollected: eggsCollected,
        onEggsCollectedChanged: (v) =>
            setState(() => eggsCollected = int.tryParse(v)),
        gradeEggs: gradeEggs,
        onGradeEggsChanged: (v) => setState(() => gradeEggs = v),
        bigEggs: bigEggs,
        onBigEggsChanged: (v) => setState(() => bigEggs = int.tryParse(v)),
        deformedEggs: deformedEggs,
        onDeformedEggsChanged: (v) =>
            setState(() => deformedEggs = int.tryParse(v)),
        brokenEggs: brokenEggs,
        onBrokenEggsChanged: (v) =>
            setState(() => brokenEggs = int.tryParse(v)),
        onContinue: _nextStep,
      ),
      // Page 4: Feeds
      FeedsPage(
        feeds: feeds,
        selectedFeed: selectedFeed,
        onFeedSelected: (v) => setState(() => selectedFeed = v),
        feedAmount: feedAmount,
        onFeedAmountChanged: (v) =>
            setState(() => feedAmount = double.tryParse(v)),
        onContinue: _nextStep,
      ),
      // Page 5: Vaccines
      VaccinesPage(
        vaccines: vaccines,
        selectedVaccine: selectedVaccine,
        onVaccineSelected: (v) => setState(() => selectedVaccine = v),
        vaccineAmount: vaccineAmount,
        onVaccineAmountChanged: (v) =>
            setState(() => vaccineAmount = double.tryParse(v)),
        onContinue: _nextStep,
      ),
      // Page 6: Other Materials
      OtherMaterialsPage(
        otherMaterials: otherMaterials,
        otherMaterialsUsed: otherMaterialsUsed,
        onMaterialUsedChanged: (item, v) {
          final val = double.tryParse(v);
          setState(() {
            if (val == null || val == 0) {
              otherMaterialsUsed.remove(item);
            } else {
              otherMaterialsUsed[item] = val;
            }
          });
        },
        onContinue: _nextStep,
      ),
      // Page 7: Additional Notes
      AdditionalNotesPage(
        selectedBatch: selectedBatch,
        notes: notes,
        onNotesChanged: (v) => setState(() => notes = v),
        onContinue: _nextStep,
      ),
      // Page 8: Review & Save
      ReviewAndSavePage(
        selectedBatch: selectedBatch,
        chickenReduction: chickenReduction,
        reductionReason: reductionReason,
        reductionCount: reductionCount,
        collectedEggs: collectedEggs,
        eggsCollected: eggsCollected,
        gradeEggs: gradeEggs,
        bigEggs: bigEggs,
        deformedEggs: deformedEggs,
        brokenEggs: brokenEggs,
        selectedFeed: selectedFeed,
        feedAmount: feedAmount,
        selectedVaccine: selectedVaccine,
        vaccineAmount: vaccineAmount,
        otherMaterialsUsed: otherMaterialsUsed,
        notes: notes,
        onSave: _saveReport,
      ),
    ];
  }

  Future<void> _saveReport() async {
    if (selectedBatch == null) return;
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    setState(() => loading = true);
    try {
      final now = DateTime.now();
      final report = <String, dynamic>{
        'user_id': user.id,
        'record_date': now.toIso8601String(),
        'created_at': now.toIso8601String(),
      };

      if (chickenReduction == 'yes' &&
          reductionReason == 'death' &&
          reductionCount != null &&
          reductionCount! > 0) {
        final newCount = (selectedBatch!.totalChickens - reductionCount!).clamp(
          0,
          selectedBatch!.totalChickens,
        );
        await SupabaseService().updateBatch({
          'id': selectedBatch!.id,
          'total_chickens': newCount,
        });
      }

      if (selectedFeed != null && feedAmount != null && feedAmount! > 0) {
        final feedQty = selectedFeed!.quantity;
        final used = feedAmount!.toInt();
        final newQty = (feedQty - used).clamp(0, feedQty);
        await SupabaseService().updateInventoryItem({
          'id': selectedFeed!.id,
          'quantity': newQty,
        });
      }

      if (selectedVaccine != null &&
          vaccineAmount != null &&
          vaccineAmount! > 0) {
        final vacQty = selectedVaccine!.quantity;
        final used = vaccineAmount!.toInt();
        final newQty = (vacQty - used).clamp(0, vacQty);
        await SupabaseService().updateInventoryItem({
          'id': selectedVaccine!.id,
          'quantity': newQty,
        });
      }

      for (final entry in otherMaterialsUsed.entries) {
        final item = entry.key;
        final used = entry.value != null ? entry.value!.toInt() : 0;
        final itemQty = item.quantity;
        if (used > 0) {
          final newQty = (itemQty - used).clamp(0, itemQty);
          await SupabaseService().updateInventoryItem({
            'id': item.id,
            'quantity': newQty,
          });
        }
      }

      final dailyRecordId = await SupabaseService().addDailyRecord(report);
      await _saveBatchRecord(dailyRecordId);

      setState(() => loading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Success'),
          content: Text(
            'Report for \\${selectedBatch?.name ?? ''} has been saved and inventory updated.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() => loading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to save report: \\$e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _saveBatchRecord(String dailyRecordId) async {
    if (selectedBatch == null) return;
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    setState(() => loading = true);
    try {
      final batchRecord = <String, dynamic>{
        'daily_record_id': dailyRecordId,
        'batch_id': selectedBatch!.id,
        'chicken_reduction': chickenReduction == 'yes',
        'chickens_sold': 0,
        'chickens_curled': reductionReason == 'curled'
            ? (reductionCount ?? 0)
            : 0,
        'chickens_died': reductionReason == 'death' ? (reductionCount ?? 0) : 0,
        'chickens_stolen': reductionReason == 'stolen'
            ? (reductionCount ?? 0)
            : 0,
        'eggs_collected': (collectedEggs == true && eggsCollected != null)
            ? eggsCollected
            : null,
        'grade_eggs': gradeEggs == true,
        'eggs_small': null,
        'eggs_deformed': deformedEggs,
        'eggs_standard': bigEggs,
        'feed_used_kg': feedAmount,
        'vaccines_given': selectedVaccine?.name,
        'notes': notes,
      };
      await SupabaseService().addBatchRecord(batchRecord);
      setState(() => loading = false);
    } catch (e) {
      setState(() => loading = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to save batch record: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
