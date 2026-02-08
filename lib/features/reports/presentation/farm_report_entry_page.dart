import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../shared/services/supabase_service.dart';
import '../../../shared/services/offline_service.dart';
import '../../../shared/services/offline_data_service.dart';
import '../../../shared/services/connectivity_manager.dart';
import '../../../shared/providers/offline_data_provider.dart';
import '../../batches/data/batch_model.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';
import '../../../shared/widgets/status_feedback_widget.dart';
import '../../../shared/screens/status_feedback_screens.dart';
import 'select_batch_page.dart';
import 'select_date_page.dart';
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
  // Multi-step flow: Batch -> Date -> ChickenReduction -> EggProduction (layers/kienyeji) -> Feeds -> Vaccines -> Other -> Notes -> Review

  bool get _isEditing =>
      (GoRouterState.of(context).extra as Map?)?.containsKey('initialStep') ??
      false;

  // Step tracking
  int step = 0;
  PageController? _pageController;
  DateTime selectedDate = DateTime.now();

  bool _isLayersOrKienyeji() {
    final type = selectedBatch?.birdType.toLowerCase().trim();
    return type == 'layer' || type == 'kienyeji';
  }

  // Helper methods to get dynamic page indices based on batch type
  int get _chickenReductionPageIndex =>
      2; // Always page 2 (after date and batch)
  int get _eggProductionPageIndex =>
      3; // Always page 3 (only shown for layers/kienyeji)
  int get _feedsPageIndex => _isLayersOrKienyeji()
      ? 4
      : 3; // After egg production or directly after chicken reduction
  int get _vaccinesPageIndex => _feedsPageIndex + 1;
  int get _otherMaterialsPageIndex => _feedsPageIndex + 2;
  int get _additionalNotesPageIndex => _feedsPageIndex + 3;

  Future<void> _animateToStep(int target) async {
    if (_pageController == null) return;
    final safeTarget = target.clamp(0, (_cachedPages?.length ?? target));
    await _pageController!.animateToPage(
      safeTarget,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
    setState(() {
      step = safeTarget;
      _invalidatePagesCache();
    });
  }

  // Data for each step
  List<Batch> batches = [];
  DateTime reportDate = DateTime.now();
  Batch? selectedBatch;
  String? chickenReduction; // yes/no
  String? reductionReason; // curled/stolen/death/sold
  int? reductionCount;
  Map<String, int> reductionCounts = {
    'curled': 0,
    'stolen': 0,
    'death': 0,
    'sold': 0,
  };
  double? salesAmount; // Amount received from sold chickens
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
  final bool _hasShownAddReportDialog =
      false; // Track if dialog was shown in this session
  bool _showingDialog = false; // Track if a dialog is currently being shown

  // Add a list to track batches already reported today
  List<String> batchesReportedToday = [];

  // Remove single-value feed, vaccine, and sawdust fields
  // Add lists for multiple feeds, vaccines, and other materials
  List<Map<String, dynamic>> selectedFeeds = [];
  List<Map<String, dynamic>> selectedVaccines = [];
  List<Map<String, dynamic>> selectedOtherMaterials = [];

  // Track reported dates for the selected batch
  List<DateTime> reportedDates = [];

  // Cache the pages list to avoid recreation during navigation
  List<Widget>? _cachedPages;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  void _initializeFromExtra() {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extra != null && extra.containsKey('initialStep')) {
      step = extra['initialStep'] as int;
      final reportData = extra['report'] as Map<String, dynamic>?;
      final batchData = extra['batch'] as Map<String, dynamic>?;

      if (batchData != null) {
        selectedBatch = Batch.fromJson(batchData);
      }

      if (reportData != null) {
        print('[FarmReportEntry] Initializing with report data: $reportData');
        reportDate =
            DateTime.tryParse(reportData['record_date'] ?? '') ??
            DateTime.now();
        selectedDate = reportDate;

        // Populate other fields from reportData
        chickenReduction = reportData['chicken_reduction'] == true
            ? 'yes'
            : 'no';
        reductionCounts = {
          'curled': reportData['chickens_curled'] ?? 0,
          'stolen': reportData['chickens_stolen'] ?? 0,
          'death': reportData['chickens_died'] ?? 0,
          'sold': reportData['chickens_sold'] ?? 0,
        };
        salesAmount = (reportData['sales_amount'] as num?)?.toDouble();
        eggsCollected = reportData['eggs_collected'];
        collectedEggs = eggsCollected != null && eggsCollected! > 0;
        gradeEggs = reportData['grade_eggs'] == true;
        bigEggs = reportData['eggs_standard'];
        deformedEggs = reportData['eggs_deformed'];
        brokenEggs = reportData['eggs_broken'];
        selectedFeeds =
            (reportData['feeds_used'] as List?)
                ?.map((e) => Map<String, dynamic>.from(e))
                .toList() ??
            [];
        selectedVaccines =
            (reportData['vaccines_used'] as List?)
                ?.map((e) => Map<String, dynamic>.from(e))
                .toList() ??
            [];
        selectedOtherMaterials =
            (reportData['other_materials_used'] as List?)
                ?.map((e) => Map<String, dynamic>.from(e))
                .toList() ??
            [];
        notes = reportData['notes'];
      }
    } else {
      step = 0;
    }

    if (selectedBatch != null) {
      _fetchReportedDates(selectedBatch!.id);
    }

    _pageController = PageController(initialPage: step);
    print('[FarmReportEntryPage] PageController initialized with step: $step');
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

      final isOnline = ConnectivityManager.instance.isOnline;

      if (isOnline) {
        // Try to fetch from server when online
        await _fetchOnlineData(user);
      } else {
        // Load from cache when offline
        await _fetchOfflineData(user);
      }
    } catch (e) {
      print('[FarmReportEntryPage] Error in _fetchInitialData: $e');
      // Fallback to offline data on any error
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await _fetchOfflineData(user);
      } else {
        setState(() {
          loading = false;
          error = 'Failed to load data: $e';
        });
      }
    }
  }

  Future<void> _fetchOnlineData(User user) async {
    try {
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

      // Cache data for offline use
      await OfflineDataProvider.instance.cacheBatches(user.id, batchListRaw);
      await OfflineDataProvider.instance.cacheInventory(user.id, inventoryRaw);

      await _processDataAndUpdateUI(batchListRaw, inventoryRaw, dailyRecords);
    } catch (e) {
      print('[FarmReportEntryPage] Error in _fetchOnlineData: $e');
      rethrow;
    }
  }

  Future<void> _fetchOfflineData(User user) async {
    try {
      print('[FarmReportEntryPage] Loading data from cache...');

      // Load cached data
      await OfflineDataProvider.instance.loadBatches();
      await OfflineDataProvider.instance.loadInventory();

      final cachedBatches = OfflineDataProvider.instance.batches;
      final cachedInventory = OfflineDataProvider.instance.inventory;

      // Convert to raw format for processing
      final batchListRaw = cachedBatches.map((b) => b.toJson()).toList();
      final inventoryRaw = cachedInventory.map((i) => i.toJson()).toList();

      // For offline mode, assume no reports today (can't check server)
      final dailyRecords = <Map<String, dynamic>>[];

      await _processDataAndUpdateUI(batchListRaw, inventoryRaw, dailyRecords);

      print(
        '[FarmReportEntryPage] Loaded ${cachedBatches.length} batches and ${cachedInventory.length} inventory items from cache',
      );
    } catch (e) {
      print('[FarmReportEntryPage] Error in _fetchOfflineData: $e');
      setState(() {
        loading = false;
        error = 'Failed to load offline data: $e';
      });
    }
  }

  Future<void> _processDataAndUpdateUI(
    List<Map<String, dynamic>> batchListRaw,
    List<Map<String, dynamic>> inventoryRaw,
    List<Map<String, dynamic>> dailyRecords,
  ) async {
    print('[FarmReportEntryPage] batchListRaw = $batchListRaw');
    print('[FarmReportEntryPage] inventoryRaw = $inventoryRaw');
    print('[FarmReportEntryPage] dailyRecords = $dailyRecords');

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
      vaccines = inventoryItems.where((i) => i.category == 'vaccine').toList();
      otherMaterials = inventoryItems
          .where((i) => i.category == 'other')
          .toList();
      batchesReportedToday = reportedBatchIds;
      _initializeFromExtra();
      loading = false;
      error = null;
      _invalidatePagesCache(); // Invalidate cache when data is loaded
    });
    print('[FarmReportEntryPage] Initialization complete.');
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
      print('[FarmReportEntryPage] Moving to Select Date step (step 1)');
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
          // Skip egg production step for non-layer/non-kienyeji batches
          print(
            '[FarmReportEntryPage] Skipping egg production for ${selectedBatch!.birdType}',
          );
          setState(() {
            step = 2; // Feeds page index
            _invalidatePagesCache();
          });
          Future.delayed(const Duration(milliseconds: 50), () {
            if (mounted && _pageController != null) {
              print('[FarmReportEntryPage] Navigating to page 2 (feeds)');
              _pageController!.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          });
          return;
        }
      }

      // Move to egg production step for layer/kienyeji batches
      print(
        '[FarmReportEntryPage] Moving to egg production step for ${selectedBatch?.birdType}',
      );
      setState(() {
        step = 2; // Egg production page index
        _invalidatePagesCache();
      });
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted && _pageController != null) {
          print('[FarmReportEntryPage] Navigating to page 2 (egg production)');
          _pageController!.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
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

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (error != null) {
      if (_hasNoInventory) {
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
            title: Text('farm_report_entry'.tr()),
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
                  Text(
                    'no_items_in_store'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                          'go_to_store'.tr(),
                          style: const TextStyle(color: CustomColors.text),
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
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          ),
          title: Text('farm_report_entry'.tr()),
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
                child: Text('retry'.tr()),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (step > 0 && _pageController != null) {
              // If on Feeds page and batch type is not layers/kienyeji, skip Egg Production
              if (step == _feedsPageIndex && !_isLayersOrKienyeji()) {
                await _animateToStep(_chickenReductionPageIndex);
              } else {
                await _animateToStep(step - 1);
              }
            } else {
              if (Navigator.of(context).canPop()) {
                Future.microtask(() {
                  if (mounted) context.pop();
                });
              } else {
                Future.microtask(() {
                  if (mounted) context.go('/');
                });
              }
            }
          },
        ),
        title: Text('farm_report_entry'.tr()),
        actions: [
          // Offline indicator - only show when offline
          ValueListenableBuilder<bool>(
            valueListenable: ConnectivityManager.instance.isOnlineNotifier,
            builder: (context, isOnline, _) {
              if (isOnline) return const SizedBox.shrink();

              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: CustomColors.lightYellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_off, size: 16, color: CustomColors.text),
                    const SizedBox(width: 4),
                    Text(
                      'offline_mode'.tr(),
                      style: TextStyle(
                        color: CustomColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (step > 0 && _pageController != null) {
            if (step == _feedsPageIndex && !_isLayersOrKienyeji()) {
              await _animateToStep(_chickenReductionPageIndex);
            } else {
              await _animateToStep(step - 1);
            }
            return false;
          } else if (Navigator.of(context).canPop()) {
            Future.microtask(() {
              if (mounted) context.pop();
            });
            return false;
          }
          return true;
        },
        child: PageView(
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
      ),
    );
  }

  void _invalidatePagesCache() {
    _cachedPages = null;
  }

  Future<void> _fetchReportedDates(String batchId) async {
    final dates = await SupabaseService().fetchReportDatesForBatch(batchId);
    setState(() {
      reportedDates = dates;
      _invalidatePagesCache();
    });
  }

  Future<void> _checkExistingReport(DateTime date) async {
    if (selectedBatch == null || _isEditing) return;

    setState(() => loading = true);
    bool alreadyReported = false;
    try {
      alreadyReported = await SupabaseService()
          .hasDailyRecordForBatch(selectedBatch!.id, date)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      print('Error checking report status: $e');
      alreadyReported = false;
    }

    setState(() => loading = false);

    if (alreadyReported && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: const Color(0xFFF7F8FA),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text(
              'already_reported_title'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text('already_reported_message'.tr()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                // Stay on step 1 (Select Date)
                if (mounted) {
                  setState(() {
                    step = 1;
                    _invalidatePagesCache();
                  });
                  _pageController?.jumpToPage(1);
                }
              },
              child: Text('ok'.tr()),
            ),
          ],
        ),
      );
    } else {
      // If no report exists, we STILL want to stay on the same page
      // to allow the user to click "Continue" manually.
      if (mounted) {
        setState(() {
          step = 1;
          _invalidatePagesCache();
        });
        _pageController?.jumpToPage(1);
      }
    }
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

      // Page 2: Select Date
      SelectDatePage(
        selectedDate: selectedDate,
        reportedDates: reportedDates,
        onDateSelected: (date) {
          setState(() {
            selectedDate = date;
            reportDate = date;
            _invalidatePagesCache();
          });
          // Check if a report already exists for this date
          _checkExistingReport(date);
        },
        onContinue: () {
          // Stay on the same page after date selection and clicking ok/continue
          print(
            '[FarmReportEntryPage] SelectDatePage onContinue called - staying on page',
          );
        },
      ),

      // Page 3: Chicken Reduction (always shown)
      ChickenReductionPage(
        chickenReduction: chickenReduction,
        onReductionChanged: (v) => setState(() {
          chickenReduction = v;
          _invalidatePagesCache();
        }),
        reductionCounts: reductionCounts,
        onCountsChanged: (counts) => setState(() {
          reductionCounts = counts;
          _invalidatePagesCache();
        }),
        onContinue: _nextStep,
        onDone: _isEditing ? _saveReport : null,
        selectedBatch: selectedBatch,
        salesAmount: salesAmount,
        onSalesAmountChanged: (amount) => setState(() {
          salesAmount = amount;
          _invalidatePagesCache();
        }),
      ),
      // Page 4: Egg Production (only for layers/kienyeji)
      if (selectedBatch != null &&
          (selectedBatch!.birdType.toLowerCase().contains('layer') ||
              selectedBatch!.birdType.toLowerCase().contains('kienyeji')))
        EggProductionPage(
          selectedBatch: selectedBatch,
          collectedEggs: collectedEggs,
          onCollectedEggsChanged: (v) => setState(() {
            collectedEggs = v;
            _invalidatePagesCache();
          }),
          eggsCollected: eggsCollected,
          onEggsCollectedChanged: (v) => setState(() {
            eggsCollected = int.tryParse(v);
            _invalidatePagesCache();
          }),
          gradeEggs: gradeEggs,
          onGradeEggsChanged: (v) => setState(() {
            gradeEggs = v;
            _invalidatePagesCache();
          }),
          bigEggs: bigEggs,
          onBigEggsChanged: (v) => setState(() {
            bigEggs = int.tryParse(v);
            _invalidatePagesCache();
          }),
          deformedEggs: deformedEggs,
          onDeformedEggsChanged: (v) => setState(() {
            deformedEggs = int.tryParse(v);
            _invalidatePagesCache();
          }),
          brokenEggs: brokenEggs,
          onBrokenEggsChanged: (v) => setState(() {
            brokenEggs = int.tryParse(v);
            _invalidatePagesCache();
          }),
          onContinue: _nextStep,
          onDone: _isEditing ? _saveReport : null,
        ),
      // Page 4: Feeds (always shown)
      FeedsPage(
        feeds: feeds,
        selectedFeeds: selectedFeeds,
        onSelectedFeedsChanged: (newFeeds) =>
            setState(() => selectedFeeds = newFeeds),
        onContinue: _nextStep,
        onDone: _isEditing ? _saveReport : null,
      ),
      // Page 5: Vaccines
      VaccinesPage(
        vaccines: vaccines,
        selectedVaccines: selectedVaccines,
        onSelectedVaccinesChanged: (newVaccines) =>
            setState(() => selectedVaccines = newVaccines),
        onContinue: _nextStep,
        onDone: _isEditing ? _saveReport : null,
      ),
      // Page 6: Other Materials
      OtherMaterialsPage(
        otherMaterials: otherMaterials,
        selectedOtherMaterials: selectedOtherMaterials,
        onSelectedOtherMaterialsChanged: (newMaterials) =>
            setState(() => selectedOtherMaterials = newMaterials),
        onContinue: _nextStep,
        onDone: _isEditing ? _saveReport : null,
      ),
      // Page 7: Additional Notes
      AdditionalNotesPage(
        selectedBatch: selectedBatch,
        notes: notes,
        onNotesChanged: (v) => setState(() => notes = v),
        onContinue: _nextStep,
        onDone: _isEditing ? _saveReport : null,
      ),
      // Page 8: Review & Save
      ReviewAndSavePage(
        selectedBatch: selectedBatch,
        chickenReduction: chickenReduction,
        reductionCounts: reductionCounts,
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
        onEditChickenReduction: () {
          _animateToStep(_chickenReductionPageIndex);
        },
        onEditEggProduction: () {
          _animateToStep(_eggProductionPageIndex);
        },
        onEditFeeds: () {
          _animateToStep(_feedsPageIndex);
        },
        onEditVaccines: () {
          _animateToStep(_vaccinesPageIndex);
        },
        onEditOtherMaterials: () {
          _animateToStep(_otherMaterialsPageIndex);
        },
        onEditAdditionalNotes: () {
          _animateToStep(_additionalNotesPageIndex);
        },
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
        }),
        SizedBox(height: 16),
      ],
    );
  }

  Future<void> _saveReport() async {
    if (selectedBatch == null) return;
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    setState(() => loading = true);
    // Capture the page context for use in dialogs after closing other dialogs
    final pageContext = context;

    try {
      // Check if device is online
      final isOnline = await OfflineService.instance.isOnline();
      print('[FarmReportEntry] Device online status: $isOnline');

      if (isOnline) {
        print(
          '[FarmReportEntry] Device is online, proceeding with online save',
        );
        // Check again before saving (in case of race condition), but allow if editing
        if (!_isEditing) {
          final alreadyReported = await SupabaseService()
              .hasDailyRecordForBatch(selectedBatch!.id, reportDate);
          if (alreadyReported) {
            setState(() => loading = false);
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: const Color(0xFFF7F8FA),
                title: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Text(
                    'already_reported_title'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Text('already_reported_message'.tr()),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('ok'.tr()),
                  ),
                ],
              ),
            );
            return;
          }
        }
      }

      final now = DateTime.now();
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
      final existingReport = extra?['report'] as Map<String, dynamic>?;

      print('[FarmReportEntry] existingReport from extra: $existingReport');

      // Prepare comprehensive report data
      final reportData = <String, dynamic>{
        if (existingReport != null && existingReport.containsKey('id'))
          'id': existingReport['id'],
        if (existingReport != null &&
            existingReport.containsKey('daily_record_id'))
          'daily_record_id': existingReport['daily_record_id'],
        'user_id': user.id,
        'record_date': existingReport != null
            ? existingReport['record_date']
            : now.toIso8601String(),
        'notes': notes,
        'batch_id': selectedBatch!.id,
        'chicken_reduction': chickenReduction == 'yes',
        'chickens_sold': reductionCounts['sold'] ?? 0,
        'chickens_died': reductionCounts['death'] ?? 0,
        'chickens_curled': reductionCounts['curled'] ?? 0,
        'chickens_stolen': reductionCounts['stolen'] ?? 0,
        'sales_amount': salesAmount ?? 0.0,
        'eggs_collected': (collectedEggs == true && eggsCollected != null)
            ? eggsCollected
            : 0,
        'grade_eggs': gradeEggs == true,
        'eggs_standard': bigEggs ?? 0, // Fixed: big_eggs -> eggs_standard
        'eggs_deformed':
            deformedEggs ?? 0, // Fixed: deformed_eggs -> eggs_deformed
        'eggs_broken': brokenEggs ?? 0, // Fixed: broken_eggs -> eggs_broken
        'selected_feeds': selectedFeeds,
        'selected_vaccines': selectedVaccines,
        'selected_other_materials': selectedOtherMaterials,
      };

      if (isOnline) {
        // Online mode - save directly to server
        await _saveReportOnline(reportData);

        // Update dashboard data after successful online save
        double totalFeedUsed = 0;
        if (reportData['selected_feeds'] is List) {
          for (final feed in reportData['selected_feeds']) {
            totalFeedUsed += (feed['quantity'] as num).toDouble();
          }
        }

        final currentDashboardData =
            OfflineDataProvider.instance.dashboardData ?? {};
        final updatedDashboardData = {
          ...currentDashboardData,
          'totalEggs':
              (currentDashboardData['totalEggs'] ?? 0) +
              (reportData['eggs_collected'] as int? ?? 0),
          'totalFeeds':
              (currentDashboardData['totalFeeds'] ?? 0) + totalFeedUsed,
        };

        await OfflineDataService.instance.cacheUserDashboard(
          Supabase.instance.client.auth.currentUser!.id,
          updatedDashboardData,
        );
        await OfflineDataProvider.instance.loadDashboardData(
          forceRefresh: true,
        );
      } else {
        // Offline mode - save locally
        print(
          '[FarmReportEntry] Device is offline, proceeding with offline save',
        );
        await _saveReportOffline(reportData);
      }

      setState(() => loading = false);
      if (!mounted) return;

      // Show success screen via the new dialog-friendly popup
      // Add a small delay to ensure the widget is stable before showing dialog
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted || _showingDialog) return;

      _showingDialog = true;
      showDialog(
        context: pageContext,
        barrierDismissible: false,
        builder: (ctx) => Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: ReportSuccessScreen(
            buttonLabel: _isEditing ? 'view_report'.tr() : null,
            onDone: () {
              Navigator.pop(ctx);
              _showingDialog = false;
              if (mounted) {
                if (_isEditing) {
                  // Pass back the updated report data to ensure UI refreshes if needed
                  // or simply pop back to the report details page which is already in the stack
                  context.pop();
                } else {
                  context.go('/');
                }
              }
            },
          ),
        ),
      );
    } catch (e) {
      setState(() => loading = false);
      if (!mounted) return;

      _showingDialog = true;
      // Show error screen via showDialog using the page context
      showDialog(
        context: pageContext,
        barrierDismissible: false,
        builder: (ctx) => Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: ReportErrorScreen(
            onTryAgain: () {
              Navigator.pop(ctx);
              _showingDialog = false;
              // Allow user to retry
            },
          ),
        ),
      );
    }
  }

  /// Save report online (when connected)
  Future<void> _saveReportOnline(Map<String, dynamic> reportData) async {
    // Calculate total reductions and update batch chicken count
    final chickensSold = (reportData['chickens_sold'] as int? ?? 0);
    final chickensDied = (reportData['chickens_died'] as int? ?? 0);
    final chickensCurled = (reportData['chickens_curled'] as int? ?? 0);
    final chickensStolen = (reportData['chickens_stolen'] as int? ?? 0);

    final totalReductions =
        chickensSold + chickensDied + chickensCurled + chickensStolen;

    if (totalReductions > 0) {
      final newCount = (selectedBatch!.totalChickens - totalReductions).clamp(
        0,
        selectedBatch!.totalChickens,
      );
      await SupabaseService().updateBatch({
        'id': selectedBatch!.id,
        'total_chickens': newCount,
      });
    }

    // Calculate financial impact
    final pricePerBird = selectedBatch!.pricePerBird;

    // Calculate losses (died, stolen, curled)
    final lossesBreakdown = <String, double>{};
    double totalLosses = 0;

    if (chickensDied > 0) {
      final deathLoss = chickensDied * pricePerBird;
      lossesBreakdown['died'] = deathLoss;
      totalLosses += deathLoss;
    }

    if (chickensStolen > 0) {
      final stolenLoss = chickensStolen * pricePerBird;
      lossesBreakdown['stolen'] = stolenLoss;
      totalLosses += stolenLoss;
    }

    if (chickensCurled > 0) {
      final curledLoss = chickensCurled * pricePerBird;
      lossesBreakdown['curled'] = curledLoss;
      totalLosses += curledLoss;
    }

    // Calculate gains (sold chickens)
    final salesAmount = (reportData['sales_amount'] as double? ?? 0.0);
    double totalGains =
        salesAmount; // This is the actual sale amount, not price_per_bird * quantity

    // Add financial data to report
    reportData['losses_amount'] = totalLosses;
    reportData['losses_breakdown'] = lossesBreakdown;
    reportData['gains_amount'] = totalGains;

    // Update inventory for selected feeds
    final selectedFeeds = reportData['selected_feeds'] as List<dynamic>? ?? [];
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
    final selectedVaccines =
        reportData['selected_vaccines'] as List<dynamic>? ?? [];
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
    final selectedOtherMaterials =
        reportData['selected_other_materials'] as List<dynamic>? ?? [];
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

    // Create/Reuse daily record
    String? dailyRecordId;
    if (reportData.containsKey('daily_record_id') &&
        reportData['daily_record_id'] != null) {
      dailyRecordId = reportData['daily_record_id'];
      print('[FarmReportEntry] Reusing dailyRecordId: $dailyRecordId');
    } else {
      final dailyRecordData = {
        'user_id': reportData['user_id'],
        'record_date':
            reportData['record_date'] ?? DateTime.now().toIso8601String(),
      };
      dailyRecordId = await SupabaseService().addDailyRecord(dailyRecordData);
      print('[FarmReportEntry] Created new dailyRecordId: $dailyRecordId');
    }

    // Create/Update batch record
    final batchRecordData = Map<String, dynamic>.from(reportData);
    batchRecordData['daily_record_id'] = dailyRecordId;
    batchRecordData.remove('user_id');
    batchRecordData.remove('record_date');
    // Keep notes in batch record - don't remove it

    // Convert selected materials to the format expected by database
    final feedsData = reportData['selected_feeds'] as List<dynamic>? ?? [];
    final vaccinesData =
        reportData['selected_vaccines'] as List<dynamic>? ?? [];
    final materialsData =
        reportData['selected_other_materials'] as List<dynamic>? ?? [];

    batchRecordData['feeds_used'] = feedsData
        .where((f) => f['quantity'] != null)
        .toList();
    batchRecordData['vaccines_used'] = vaccinesData
        .where((v) => v['quantity'] != null)
        .toList();
    batchRecordData['other_materials_used'] = materialsData
        .where((m) => m['quantity'] != null)
        .toList();

    // Remove the original selected_ fields
    batchRecordData.remove('selected_feeds');
    batchRecordData.remove('selected_vaccines');
    batchRecordData.remove('selected_other_materials');

    await SupabaseService().addBatchRecord(batchRecordData);
  }

  /// Save report offline (when disconnected)
  Future<void> _saveReportOffline(Map<String, dynamic> reportData) async {
    try {
      print('[FarmReportEntry] Attempting to save report offline');
      print('[FarmReportEntry] Report data keys: ${reportData.keys}');

      final reportId = await OfflineService.instance.saveFarmReportOffline(
        reportData,
      );
      print(
        '[FarmReportEntry] Successfully saved offline report with ID: $reportId',
      );

      // Update connectivity manager to refresh pending count
      await ConnectivityManager.instance.refreshConnectivity();
      print('[FarmReportEntry] Updated connectivity manager');
    } catch (e) {
      print('[FarmReportEntry] Error saving offline report: $e');
      rethrow;
    }
  }
}
