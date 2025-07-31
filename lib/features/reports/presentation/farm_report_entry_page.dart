import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/services/supabase_service.dart';
import '../../batches/data/batch_model.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';
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
  bool _hasNoInventory = false; // Track if there are no inventory items
  bool _hasShownAddReportDialog =
      false; // Track if dialog was shown in this session
  bool _showingDialog = false; // Track if a dialog is currently being shown

  // Add a list to track batches already reported today
  List<String> batchesReportedToday = [];

  // Remove single-value feed, vaccine, and sawdust fields
  // Add lists for multiple feeds, vaccines, and other materials
  List<Map<String, dynamic>> selectedFeeds = [];
  List<Map<String, dynamic>> selectedVaccines = [];
  List<Map<String, dynamic>> selectedOtherMaterials = [];

  // Cache the pages list to avoid recreation during navigation
  List<Widget>? _cachedPages;

  @override
  void initState() {
    super.initState();
    step = 0; // Ensure step starts at 0
    _pageController = PageController(initialPage: 0);
    print('[FarmReportEntryPage] PageController initialized with step: $step');
    _fetchInitialData();
  }

  @override
  void dispose() {
    _showingDialog = false; // Reset dialog flag
    _pageController?.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        setState(() {
          loading = false;
          error = 'Not signed in.';
        });
        return;
      }
      // Fetch batches and inventory with timeout
      final batchListRaw = await SupabaseService()
          .fetchBatches(user.id)
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('Timeout while fetching batches');
            },
          );
      final inventoryRaw = await SupabaseService()
          .fetchInventory(user.id)
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('Timeout while fetching inventory');
            },
          );
      // Fetch daily records for today
      final today = DateTime.now();
      final dailyRecords = await SupabaseService()
          .fetchDailyRecordsForDate(user.id, today)
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('Timeout while fetching daily records');
            },
          );
      print('[FarmReportEntryPage] batchListRaw = ' + batchListRaw.toString());
      print('[FarmReportEntryPage] inventoryRaw = ' + inventoryRaw.toString());
      print('[FarmReportEntryPage] dailyRecords = ' + dailyRecords.toString());
      final reportedBatchIds = <String>[];
      for (final record in dailyRecords) {
        if (record['batch_id'] != null) {
          reportedBatchIds.add(record['batch_id']);
        }
      }
      List<Batch> loadedBatches = [];
      List<InventoryItem> inventoryItems = [];
      try {
        loadedBatches = batchListRaw.map((e) => Batch.fromJson(e)).toList();
        inventoryItems = inventoryRaw
            .map((e) => InventoryItem.fromJson(e))
            .toList();
      } catch (e) {
        setState(() {
          loading = false;
          error = 'Data error: $e';
        });
        print('[FarmReportEntryPage] Data error: $e');
        return;
      }
      if (loadedBatches.isEmpty) {
        setState(() {
          loading = false;
          error = 'No batches found. Please add a batch first.';
        });
        print('[FarmReportEntryPage] No batches found.');
        return;
      }
      if (inventoryItems.where((i) => i.category == 'feed').isEmpty &&
          inventoryItems.where((i) => i.category == 'vaccine').isEmpty &&
          inventoryItems.where((i) => i.category == 'other').isEmpty) {
        setState(() {
          loading = false;
          error = 'No inventory found. Please add inventory items first.';
          _hasNoInventory = true;
        });
        print('[FarmReportEntryPage] No inventory found.');
        return;
      }
      setState(() {
        batches = loadedBatches;
        feeds = inventoryItems.where((i) => i.category == 'feed').toList();
        vaccines = inventoryItems
            .where((i) => i.category == 'vaccine')
            .toList();
        otherMaterials = inventoryItems
            .where((i) => i.category == 'other')
            .toList();
        batchesReportedToday = reportedBatchIds;
        loading = false;
        error = null;
        _invalidatePagesCache(); // Invalidate cache when data is loaded
      });
      print('[FarmReportEntryPage] Initialization complete.');
    } catch (e) {
      setState(() {
        loading = false;
        error = 'Failed to load data: $e';
      });
      print('[FarmReportEntryPage] Failed to load data: $e');
    }
  }

  void _nextStep() async {
    print('[FarmReportEntryPage] _nextStep called, current step: $step');
    print(
      '[FarmReportEntryPage] Selected batch: ${selectedBatch?.name} (${selectedBatch?.birdType})',
    );

    // Ensure page controller is available
    if (_pageController == null) {
      print('[FarmReportEntryPage] PageController is null, initializing...');
      _pageController = PageController(initialPage: step);
    }

    // If we're on the batch selection step (step 0) and a batch is selected
    if (step == 0 && selectedBatch != null) {
      print(
        '[FarmReportEntryPage] On batch selection step with batch selected, checking if already reported',
      );
      setState(() => loading = true);
      bool? alreadyReported;
      String? errorMsg;
      try {
        alreadyReported = await SupabaseService()
            .hasDailyRecordForBatch(selectedBatch!.id, DateTime.now())
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                errorMsg =
                    'Request timed out. Please check your connection and try again.';
                return false;
              },
            );
      } catch (e) {
        print('Error checking report status: $e');
        // If there's an error checking status, allow the user to proceed
        // This prevents blocking due to database issues
        alreadyReported = false;
        errorMsg = null;
      }
      if (errorMsg != null) {
        setState(() => loading = false);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: const Color(0xFFF7F8FA),
            title: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                'Error',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(errorMsg!),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
      if (alreadyReported == true) {
        setState(() => loading = false);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: const Color(0xFFF7F8FA),
            title: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                'Already Reported',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                'You have already submitted a report for this batch today. Please try again tomorrow.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
      print('[FarmReportEntryPage] Moving to chicken reduction step (step 1)');
      setState(() {
        loading = false;
        step = 1;
        _invalidatePagesCache();
      });
      // Use a small delay to ensure state is updated before animating
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted && _pageController != null) {
          // We know we have at least 8 pages (0-7), so page 1 should exist
          print(
            '[FarmReportEntryPage] Navigating to page 1 (chicken reduction)',
          );
          _pageController!.animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      });
      return;
    }

    // If we're on the chicken reduction step (step 1)
    if (step == 1) {
      print(
        '[FarmReportEntryPage] On chicken reduction step, moving to next step',
      );

      // Check if we need to skip the egg production step for non-layer/non-kienyeji batches
      if (selectedBatch != null) {
        final isLayerOrKienyeji =
            selectedBatch!.birdType.toLowerCase().contains('layer') ||
            selectedBatch!.birdType.toLowerCase().contains('kienyeji');

        if (!isLayerOrKienyeji) {
          // Skip egg production step (step 2) for non-layer/non-kienyeji batches
          print(
            '[FarmReportEntryPage] Skipping egg production for ${selectedBatch!.birdType}',
          );
          setState(() {
            step = 3;
            _invalidatePagesCache();
          }); // Jump directly to feeds step
          // Use a small delay to ensure state is updated before animating
          Future.delayed(const Duration(milliseconds: 50), () {
            if (mounted && _pageController != null) {
              print('[FarmReportEntryPage] Navigating to page 3 (feeds)');
              _pageController!.animateToPage(
                3,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          });
          return;
        }
      }

      // Move to egg production step (step 2) for layer/kienyeji batches
      print(
        '[FarmReportEntryPage] Moving to egg production step for ${selectedBatch?.birdType}',
      );
      print(
        '[FarmReportEntryPage] Batch type check: ${selectedBatch?.birdType.toLowerCase().contains('layer')} or ${selectedBatch?.birdType.toLowerCase().contains('kienyeji')}',
      );
      setState(() {
        step = 2;
        _invalidatePagesCache();
      });
      // Use a small delay to ensure state is updated before animating
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted && _pageController != null) {
          print('[FarmReportEntryPage] Navigating to page 2 (egg production)');
          print(
            '[FarmReportEntryPage] PageController current page: ${_pageController!.page}',
          );
          try {
            _pageController!.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          } catch (e) {
            print('[FarmReportEntryPage] Error animating to page 2: $e');
          }
        }
      });
      return;
    }

    // For all other steps, just move to the next step
    print('[FarmReportEntryPage] Moving to next step: ${step + 1}');
    setState(() {
      step++;
      _invalidatePagesCache();
    });
    // Use a small delay to ensure state is updated before animating
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted && _pageController != null) {
        _pageController!.animateToPage(
          step,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
      '[FarmReportEntryPage] Building with step: $step, pageController: ${_pageController != null ? "available" : "null"}',
    );

    // Ensure page controller is initialized
    if (_pageController == null) {
      print(
        '[FarmReportEntryPage] PageController is null in build, initializing...',
      );
      _pageController = PageController(initialPage: step);
    }

    if (loading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (error != null) {
      if (_hasNoInventory) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
            ),
            title: const Text('Farm Report Entry'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/amico.png',
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'It seems you have no items in your store. Go to your store and add items to continue.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: CustomColors.text,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: CustomColors.buttonGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.store, color: CustomColors.text),
                        label: Text(
                          'Go to Store',
                          style: TextStyle(color: CustomColors.text),
                        ),
                        onPressed: () {
                          context.go('/inventory-categories');
                        },
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
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
          title: const Text('Farm Report Entry'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchInitialData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
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
          // Update step when page changes to keep them in sync
          print(
            '[FarmReportEntryPage] onPageChanged called with index: $index, current step: $step',
          );
          setState(() {
            step = index;
            _invalidatePagesCache(); // Invalidate cache when step changes
          });
          print('[FarmReportEntryPage] Step updated to: $step');
          print(
            '[FarmReportEntryPage] Current batch: ${selectedBatch?.name} (${selectedBatch?.birdType})',
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        children: _buildPages(),
      ),
    );
  }

  void _invalidatePagesCache() {
    _cachedPages = null;
  }

  List<Widget> _buildPages() {
    // Return cached pages if available
    if (_cachedPages != null) {
      return _cachedPages!;
    }

    _cachedPages = [
      // Page 1: Select Batch
      SelectBatchPage(
        batches: batches,
        selectedBatch: selectedBatch,
        onBatchSelected: (batch) {
          setState(() {
            selectedBatch = batch;
            _invalidatePagesCache(); // Invalidate cache when batch changes
          });
        },
        onContinue: () {
          print('[FarmReportEntryPage] SelectBatchPage onContinue called');
          if (selectedBatch == null) {
            print('[FarmReportEntryPage] No batch selected, returning');
            return;
          }
          print('[FarmReportEntryPage] Calling _nextStep from SelectBatchPage');
          _nextStep(); // Call directly, not in post-frame callback
        },
        batchesReportedToday: batchesReportedToday, // Pass this to the page
      ),
      // Page 2: Chicken Reduction (always shown)
      ChickenReductionPage(
        chickenReduction: chickenReduction,
        onReductionChanged: (v) => setState(() {
          chickenReduction = v;
          _invalidatePagesCache();
        }),
        reductionReason: reductionReason,
        onReasonChanged: (v) => setState(() {
          reductionReason = v;
          _invalidatePagesCache();
        }),
        reductionCount: reductionCount,
        onCountChanged: (v) => setState(() {
          reductionCount = int.tryParse(v);
          _invalidatePagesCache();
        }),
        onContinue: _nextStep,
        selectedBatch: selectedBatch,
      ),
      // Page 3: Egg Production (only for layers/kienyeji)
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Egg Production Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Batch: ${selectedBatch?.name ?? 'None'}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Type: ${selectedBatch?.birdType ?? 'None'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _nextStep,
                child: Text('Continue to Feeds'),
              ),
            ],
          ),
        ),
      ),
      // Page 4: Feeds
      FeedsPage(
        feeds: feeds,
        selectedFeeds: selectedFeeds,
        onSelectedFeedsChanged: (newFeeds) =>
            setState(() => selectedFeeds = newFeeds),
        onContinue: _nextStep,
      ),
      // Page 5: Vaccines
      VaccinesPage(
        vaccines: vaccines,
        selectedVaccines: selectedVaccines,
        onSelectedVaccinesChanged: (newVaccines) =>
            setState(() => selectedVaccines = newVaccines),
        onContinue: _nextStep,
      ),
      // Page 6: Other Materials
      OtherMaterialsPage(
        otherMaterials: otherMaterials,
        selectedOtherMaterials: selectedOtherMaterials,
        onSelectedOtherMaterialsChanged: (newMaterials) =>
            setState(() => selectedOtherMaterials = newMaterials),
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
        selectedFeeds: selectedFeeds,
        selectedVaccines: selectedVaccines,
        selectedOtherMaterials: selectedOtherMaterials,
      ),
    ];

    return _cachedPages!;
  }

  // Add helper widgets for dynamic entry lists
  Widget _buildDynamicEntryList({
    required String title,
    required List<Map<String, dynamic>> entries,
    required List<InventoryItem> options,
    required VoidCallback onAdd,
    required void Function(int) onRemove,
    required void Function(int, InventoryItem?) onItemChanged,
    required void Function(int, String) onQtyChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ...List.generate(entries.length, (i) {
          InventoryItem? selectedItem;
          try {
            selectedItem = options.firstWhere(
              (opt) => opt.name == entries[i]['name'],
            );
          } catch (_) {
            selectedItem = null;
          }
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButton<InventoryItem>(
                  isExpanded: true,
                  value: selectedItem,
                  hint: Text('Select item'),
                  items: options
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => onItemChanged(i, val),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(hintText: 'Qty'),
                  onChanged: (v) => onQtyChanged(i, v),
                  controller: TextEditingController(
                    text: entries[i]['quantity']?.toString() ?? '',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => onRemove(i),
              ),
            ],
          );
        }),
        TextButton.icon(
          onPressed: onAdd,
          icon: Icon(Icons.add),
          label: Text('Add'),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Replace the DropdownButton for feeds with a button that opens a dialog with a checkbox list of all feeds.
  // For each selected feed, show a quantity input in the main UI.
  // Save the selected feeds and their quantities in selectedFeeds.

  Widget _buildFeedsCheckboxSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Feeds Used',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Wrap(
          children: feeds.map((feed) {
            final idx = selectedFeeds.indexWhere((f) => f['name'] == feed.name);
            final isSelected = idx != -1;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        selectedFeeds.add({
                          'name': feed.name,
                          'quantity': null,
                        });
                      } else {
                        selectedFeeds.removeWhere(
                          (f) => f['name'] == feed.name,
                        );
                      }
                    });
                  },
                ),
                Text(feed.name),
                SizedBox(width: 8),
              ],
            );
          }).toList(),
        ),
        ...selectedFeeds.map((f) {
          return Row(
            children: [
              Expanded(flex: 2, child: Text(f['name'])),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(hintText: 'Qty'),
                  onChanged: (v) =>
                      setState(() => f['quantity'] = double.tryParse(v)),
                  controller: TextEditingController(
                    text: f['quantity']?.toString() ?? '',
                  ),
                ),
              ),
            ],
          );
        }).toList(),
        SizedBox(height: 16),
      ],
    );
  }

  Future<void> _saveReport() async {
    if (selectedBatch == null) return;
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    setState(() => loading = true);

    try {
      // Check again before saving (in case of race condition)
      final alreadyReported = await SupabaseService().hasDailyRecordForBatch(
        selectedBatch!.id,
        DateTime.now(),
      );
      if (alreadyReported) {
        setState(() => loading = false);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: const Color(0xFFF7F8FA),
            title: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                'Already Reported',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                'You have already submitted a report for this batch today. Please try again tomorrow.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      final now = DateTime.now();
      final report = <String, dynamic>{
        'user_id': user.id,
        'record_date': now.toIso8601String(),
        'created_at': now.toIso8601String(),
      };

      // Update batch chicken count if deaths reported
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

      // Update inventory for selected feeds
      for (final feedData in selectedFeeds) {
        final feedName = feedData['name'] as String?;
        final quantity = feedData['quantity'] as double?;
        if (feedName != null && quantity != null && quantity > 0) {
          final feed = feeds.firstWhere(
            (f) => f.name == feedName,
            orElse: () => throw Exception('Feed not found: $feedName'),
          );
          final newQty = (feed.quantity - quantity.toInt()).clamp(
            0,
            feed.quantity,
          );
          await SupabaseService().updateInventoryItem({
            'id': feed.id,
            'quantity': newQty,
          });
        }
      }

      // Update inventory for selected vaccines
      for (final vaccineData in selectedVaccines) {
        final vaccineName = vaccineData['name'] as String?;
        final quantity = vaccineData['quantity'] as double?;
        if (vaccineName != null && quantity != null && quantity > 0) {
          final vaccine = vaccines.firstWhere(
            (v) => v.name == vaccineName,
            orElse: () => throw Exception('Vaccine not found: $vaccineName'),
          );
          final newQty = (vaccine.quantity - quantity.toInt()).clamp(
            0,
            vaccine.quantity,
          );
          await SupabaseService().updateInventoryItem({
            'id': vaccine.id,
            'quantity': newQty,
          });
        }
      }

      // Update inventory for selected other materials
      for (final materialData in selectedOtherMaterials) {
        final materialName = materialData['name'] as String?;
        final quantity = materialData['quantity'] as double?;
        if (materialName != null && quantity != null && quantity > 0) {
          final material = otherMaterials.firstWhere(
            (m) => m.name == materialName,
            orElse: () => throw Exception('Material not found: $materialName'),
          );
          final newQty = (material.quantity - quantity.toInt()).clamp(
            0,
            material.quantity,
          );
          await SupabaseService().updateInventoryItem({
            'id': material.id,
            'quantity': newQty,
          });
        }
      }

      final dailyRecordId = await SupabaseService().addDailyRecord(report);
      await _saveBatchRecord(dailyRecordId);

      setState(() => loading = false);
      if (!mounted) return;

      // Add a small delay to ensure the widget is stable before showing dialog
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted || _showingDialog) return;

      _showingDialog = true;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: const Color(0xFFF7F8FA),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text(
              'Success',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text(
              'Report for ${selectedBatch?.name ?? ''} has been saved and inventory updated.',
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Close the dialog first
                  _showingDialog = false;
                  Navigator.of(ctx).pop();
                  // Use a small delay to ensure the dialog is fully closed
                  Future.delayed(const Duration(milliseconds: 200), () {
                    if (mounted) {
                      try {
                        // Navigate directly to reports page
                        context.go('/reports');
                      } catch (e) {
                        print('Navigation error: $e');
                        // Fallback: try to pop and then navigate
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    }
                  });
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
                    child: const Text('See Reports'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() => loading = false);
      if (!mounted) return;

      // Add a small delay to ensure the widget is stable before showing dialog
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted || _showingDialog) return;

      // Handle specific constraint violation error
      String errorMessage = 'Failed to save report: $e';
      if (e.toString().contains('unique_user_date')) {
        errorMessage =
            'A report for this batch has already been submitted today. Please try again tomorrow.';
      } else if (e.toString().contains('duplicate key')) {
        errorMessage =
            'This report has already been submitted. Please check your reports.';
      } else if (e.toString().contains('multiple (or no) rows returned')) {
        errorMessage =
            'There was an issue checking the report status. Please try again.';
      }

      _showingDialog = true;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: const Color(0xFFF7F8FA),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text(
              'Error',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text(errorMessage),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _showingDialog = false;
                Navigator.of(ctx).pop();
              },
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
        'feeds_used': selectedFeeds, // List of {name, quantity}
        'vaccines_used': selectedVaccines, // List of {name, quantity}
        'other_materials_used':
            selectedOtherMaterials, // List of {name, quantity}
        'notes': notes,
      };
      await SupabaseService().addBatchRecord(batchRecord);
    } catch (e) {
      print('Error saving batch record: $e');
      // Just rethrow the error to be handled by the main save function
      // Don't show dialog here to avoid multiple dialogs
      rethrow;
    }
  }
}
