import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:io';

import '../../batches/data/batch_model.dart';
import '../../../app_theme.dart';
import '../../../shared/services/supabase_service.dart';

class FarmSummaryPage extends StatefulWidget {
  const FarmSummaryPage({super.key});

  @override
  State<FarmSummaryPage> createState() => _FarmSummaryPageState();
}

class _FarmSummaryPageState extends State<FarmSummaryPage> {
  DateTimeRange? selectedRange;
  bool loading = true;
  bool isOffline = false;
  List<Batch> batches = [];
  Map<String, _BatchSummary> summariesByBatchId = {};
  Map<String, Map<String, dynamic>> inventoryMap = {};
  Batch? selectedBatch;

  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> _initConnectivity() async {
    try {
      final result = await Connectivity().checkConnectivity();
      setState(() {
        isOffline = result == ConnectivityResult.none;
      });
      if (!isOffline) {
        _loadData();
      }
    } catch (e) {
      setState(() => isOffline = true);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _showEditOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('edit_farm_summary'.tr()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_note),
                title: Text('edit_report'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  _showReportEditDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text('delete_report'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReportEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('edit_report'.tr()),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              DropdownButtonFormField<String>(
                value: null,
                decoration: InputDecoration(labelText: 'select_batch'.tr()),
                items: batches
                    .map(
                      (batch) => DropdownMenuItem(
                        value: batch.id,
                        child: Text(batch.name),
                      ),
                    )
                    .toList(),
                onChanged: (batchId) {
                  if (batchId != null) {
                    Navigator.pop(context);
                    _editBatchReport(batchId);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('confirm_delete'.tr()),
        content: Text('delete_report_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _deleteReport();
            },
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }

  Future<void> _editBatchReport(String batchId) async {
    // Navigate to farm report entry page with edit mode
    if (!mounted) return;

    final batch = batches.firstWhere((b) => b.id == batchId);
    final result = await context.push<bool>(
      '/farm-report/edit/$batchId',
      extra: {'batch': batch, 'date': selectedRange?.start ?? DateTime.now()},
    );

    if (result == true) {
      await _loadData(); // Refresh the data
    }
  }

  Future<void> _deleteReport() async {
    try {
      setState(() => loading = true);

      // Delete the report from Supabase
      await SupabaseService().supabase.from('farm_reports').delete().match({
        'batch_id': selectedBatch?.id ?? '',
        'report_date': DateFormat(
          'yyyy-MM-dd',
        ).format(selectedRange?.start ?? DateTime.now()),
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('report_deleted'.tr())));
      }

      await _loadData(); // Refresh the data
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('delete_error'.tr())));
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Default to last 7 days
    final now = DateTime.now();
    selectedRange = DateTimeRange(
      start: now.subtract(const Duration(days: 7)),
      end: now.add(const Duration(days: 1)),
    );
    _initConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) {
      setState(() {
        isOffline = result == ConnectivityResult.none;
      });
      if (!isOffline) {
        _loadData();
      }
    });
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
      initialDateRange: selectedRange,
    );
    if (result != null) {
      setState(() {
        selectedRange = result;
      });
      await _loadData();
    }
  }

  Future<void> _loadData() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null || selectedRange == null) {
      setState(() => loading = false);
      return;
    }
    setState(() => loading = true);
    try {
      // Fetch batches and sort by createdAt ascending (oldest to newest)
      final rawBatches = await SupabaseService().fetchBatches(user.id);
      final parsedBatches = rawBatches.map((b) => Batch.fromJson(b)).toList();
      parsedBatches.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      // Fetch daily records in range
      final dailyRecords = await SupabaseService().fetchDailyRecordsInRange(
        user.id,
        selectedRange!.start,
        selectedRange!.end,
      );
      final dailyRecordIds = dailyRecords
          .map((e) => e['id'] as String)
          .toList();

      // Fetch batch records for those daily records
      final batchRecords = await SupabaseService()
          .fetchBatchRecordsForDailyRecordIds(dailyRecordIds);

      // Fetch inventory items to get prices
      final inventoryItems = await SupabaseService().fetchInventory(user.id);
      inventoryMap.clear();
      for (final item in inventoryItems) {
        inventoryMap[item['name']] = item;
      }

      // Initialize summaries
      final Map<String, _BatchSummary> tmp = {};
      final Set<String> batchCostsAdded =
          {}; // Track which batches have had their initial costs added

      for (final br in batchRecords) {
        final batchId = br['batch_id'] as String?;
        if (batchId == null) continue;
        final feedsUsed = br['feeds_used'];
        final chickensDied = (br['chickens_died'] as int?) ?? 0;
        final salesAmount = (br['sales_amount'] as num?)?.toDouble() ?? 0.0;
        final lossesAmount = (br['losses_amount'] as num?)?.toDouble() ?? 0.0;
        final lossesBreakdown =
            br['losses_breakdown'] as Map<String, dynamic>? ?? {};
        // Note: eggs_sold and eggs_price_per_unit fields don't exist in batch_records table
        // Egg sales logic needs to be implemented properly in the future
        final vaccinesUsed = br['vaccines_used'];
        final otherMaterialsUsed = br['other_materials_used'];

        tmp.putIfAbsent(batchId, () => _BatchSummary());
        final sum = tmp[batchId]!;

        // Add initial bird cost only once per batch
        if (!batchCostsAdded.contains(batchId)) {
          final batch = parsedBatches.firstWhere((b) => b.id == batchId);
          final initialBirdCost = batch.totalChickens * batch.pricePerBird;
          sum.expensesByCategory['bird_cost'] =
              (sum.expensesByCategory['bird_cost'] ?? 0.0) + initialBirdCost;
          sum.totalExpenses += initialBirdCost;
          batchCostsAdded.add(batchId);
        }

        // Calculate sales from chickens (eggs sales to be implemented later)
        final chickenSales = salesAmount; // Use the total sales amount directly

        // Add chicken sales to the summary
        sum.salesByCategory['chickens'] =
            (sum.salesByCategory['chickens'] ?? 0.0) + chickenSales;
        sum.totalSales += chickenSales; // Only chicken sales for now

        // Add losses from chicken reductions (deaths, stolen, curled)
        if (lossesAmount > 0) {
          sum.totalExpenses += lossesAmount;
          sum.expensesByCategory['livestock_losses'] =
              (sum.expensesByCategory['livestock_losses'] ?? 0.0) +
              lossesAmount;

          // Track detailed losses breakdown
          if (lossesBreakdown.isNotEmpty) {
            lossesBreakdown.forEach((type, amount) {
              final lossAmount = (amount as num).toDouble();
              sum.expensesByCategory['losses_$type'] =
                  (sum.expensesByCategory['losses_$type'] ?? 0.0) + lossAmount;
            });
          }
        }

        // Sum feeds_used list quantities and calculate expenses
        if (feedsUsed is List) {
          for (final item in feedsUsed) {
            if (item is Map && item['quantity'] != null) {
              final qty = (item['quantity'] as num).toDouble();
              final name = item['name'] as String?;
              if (name != null) {
                sum.totalFeedKg += qty;
                sum.feedsByType[name] = (sum.feedsByType[name] ?? 0.0) + qty;

                // Calculate expenses for feeds
                if (inventoryMap.containsKey(name)) {
                  final price =
                      (inventoryMap[name]!['price'] as num?)?.toDouble() ?? 0.0;
                  final feedExpense = qty * price;
                  sum.totalExpenses += feedExpense;
                  sum.expensesByCategory['feeds'] =
                      (sum.expensesByCategory['feeds'] ?? 0.0) + feedExpense;
                }
              }
            }
          }
        }

        // Calculate expenses for vaccines and track quantities
        if (vaccinesUsed is List) {
          for (final item in vaccinesUsed) {
            if (item is Map &&
                item['quantity'] != null &&
                item['name'] != null) {
              final qty = (item['quantity'] as num).toDouble();
              final name = item['name'] as String;

              // Add or update vaccine quantity in the map
              sum.vaccineQuantities[name] =
                  (sum.vaccineQuantities[name] ?? 0.0) + qty;
              sum.totalVaccinations += 1;

              // Calculate expenses
              if (inventoryMap.containsKey(name)) {
                final price =
                    (inventoryMap[name]!['price'] as num?)?.toDouble() ?? 0.0;
                final vaccineExpense = qty * price;
                sum.totalExpenses += vaccineExpense;
                sum.expensesByCategory['vaccines'] =
                    (sum.expensesByCategory['vaccines'] ?? 0.0) +
                    vaccineExpense;
              }
            }
          }
        }

        // Calculate expenses for other materials and track usage
        if (otherMaterialsUsed is List) {
          for (final item in otherMaterialsUsed) {
            if (item is Map &&
                item['quantity'] != null &&
                item['name'] != null) {
              final qty = (item['quantity'] as num).toDouble();
              final name = item['name'] as String;

              // Track material usage
              sum.materialUsage[name] = (sum.materialUsage[name] ?? 0.0) + qty;

              if (inventoryMap.containsKey(name)) {
                final price =
                    (inventoryMap[name]!['price'] as num?)?.toDouble() ?? 0.0;
                final materialExpense = qty * price;
                sum.totalExpenses += materialExpense;
                sum.expensesByCategory['other_materials'] =
                    (sum.expensesByCategory['other_materials'] ?? 0.0) +
                    materialExpense;
              }
            }
          }
        }

        // Calculate final profit
        sum.totalProfit = sum.totalSales - sum.totalExpenses;

        // Track mortality count for display purposes
        sum.totalMortality += chickensDied;
      }

      // Ensure every batch has its initial bird cost included, even if no records exist for it
      for (final batch in parsedBatches) {
        final sum = tmp.putIfAbsent(batch.id, () => _BatchSummary());
        if ((sum.expensesByCategory['bird_cost'] ?? 0.0) == 0.0 &&
            batch.totalChickens > 0 &&
            batch.pricePerBird > 0) {
          final initialBirdCost = batch.totalChickens * batch.pricePerBird;
          sum.expensesByCategory['bird_cost'] = initialBirdCost;
          sum.totalExpenses += initialBirdCost;
        }
      }

      setState(() {
        batches = parsedBatches;
        summariesByBatchId = tmp;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  void _exportPdf() {
    _generateAndSavePdf();
  }

  Future<void> _generateAndSavePdf() async {
    try {
      final doc = pw.Document();
      final dateLabel = selectedRange == null
          ? ''
          : '${DateFormat.yMMMd().format(selectedRange!.start)} - ${DateFormat.yMMMd().format(selectedRange!.end.subtract(const Duration(days: 1)))}';

      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              pw.Text(
                'Farm Summary',
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(dateLabel, style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 16),
              pw.TableHelper.fromTextArray(
                headers: [
                  'Batch',
                  'Feeds Used (kg) & Price/kg',
                  'Mortality',
                  'Vaccines Used (L) & Price/L',
                  'Total Expenses',
                ],
                data: batches.map((b) {
                  final s = summariesByBatchId[b.id] ?? _BatchSummary();
                  return [
                    b.name,
                    s.feedsByType.entries
                        .map(
                          (f) =>
                              '${f.key}: ${f.value.toStringAsFixed(2)} kg @ Ksh ${(inventoryMap[f.key]?['price'] as num?)?.toStringAsFixed(2) ?? '0.00'}/kg',
                        )
                        .join('\n'),
                    s.totalMortality.toString(),
                    s.vaccineQuantities.entries
                        .map(
                          (v) =>
                              '${v.key}: ${v.value.toStringAsFixed(2)} L @ Ksh ${(inventoryMap[v.key]?['price'] as num?)?.toStringAsFixed(2) ?? '0.00'}/L',
                        )
                        .join('\n'),
                    'Ksh ${s.totalExpenses.toStringAsFixed(2)}',
                  ];
                }).toList(),
              ),
            ];
          },
        ),
      );

      final bytes = await doc.save();
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
        '${dir.path}/farm_summary_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(bytes);

      // Offer share/print as well
      await Printing.sharePdf(
        bytes: bytes,
        filename: file.path.split('/').last,
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('pdf_saved'.tr())));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('pdf_error'.tr())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('farm_summary'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.pop(context);
            } else {
              context.go('/');
            }
          },
        ),
        actions: [
          if (!isOffline) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditOptions(context),
              tooltip: 'Edit Farm Summary',
            ),
          ],
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: summariesByBatchId.isEmpty ? null : _exportPdf,
            tooltip: 'Download Farm Summary',
          ),
        ],
      ),
      body: isOffline
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'You are offline',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please connect to the internet to access your farm summary',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.text.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _initConnectivity,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Farm Overview Card
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // Use the app's secondary light color for the My Farm card
                    color: CustomColors.lightYellow,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My Farm',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.text,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${batches.length} Active Batches',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.text,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: CustomColors.text,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedRange == null
                                        ? ''
                                        : '${DateFormat.MMMd().format(selectedRange!.start)} - ${DateFormat.MMMd().format(selectedRange!.end.subtract(const Duration(days: 1)))}',
                                    style: const TextStyle(
                                      color: CustomColors.text,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: _pickDateRange,
                          icon: const Icon(
                            Icons.date_range,
                            color: CustomColors.text,
                          ),
                          label: Text(
                            'Change Date Range',
                            style: const TextStyle(color: CustomColors.text),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: CustomColors.text),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        // Batch selector dropdown if multiple batches
                        if (batches.length > 1) ...[
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String?>(
                            value: selectedBatch?.id,
                            decoration: InputDecoration(
                              labelText: 'Select Batch (Optional)',
                              labelStyle: const TextStyle(
                                color: CustomColors.text,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: CustomColors.text,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: CustomColors.text.withOpacity(0.5),
                                ),
                              ),
                            ),
                            items: [
                              DropdownMenuItem<String?>(
                                value: null,
                                child: Text(
                                  'All Batches (Farm Overview)',
                                  style: TextStyle(color: CustomColors.text),
                                ),
                              ),
                              ...batches.map(
                                (batch) => DropdownMenuItem<String?>(
                                  value: batch.id,
                                  child: Text(
                                    '${batch.name} (${batch.birdType.toUpperCase()})',
                                    style: TextStyle(color: CustomColors.text),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (batchId) {
                              setState(() {
                                if (batchId == null) {
                                  selectedBatch = null;
                                } else {
                                  selectedBatch = batches.firstWhere(
                                    (b) => b.id == batchId,
                                  );
                                }
                              });
                            },
                            isExpanded: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _getDisplayedBatchCount(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      // Get the list of batches to display
                      final displayedBatches = _getDisplayedBatches();

                      // Show grand total if viewing all batches and there are multiple batches
                      if (index == displayedBatches.length &&
                          selectedBatch == null &&
                          batches.length > 1) {
                        // Calculate totals from displayed batches only
                        double totalSales = 0;
                        double totalExpenses = 0;
                        double totalProfit = 0;
                        for (final batch in displayedBatches) {
                          final sum =
                              summariesByBatchId[batch.id] ?? _BatchSummary();
                          totalSales += sum.totalSales;
                          totalExpenses += sum.totalExpenses;
                          totalProfit += sum.totalProfit;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: CustomColors.primary.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Sales',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.text,
                                            ),
                                          ),
                                          Text(
                                            'Ksh ${totalSales.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
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
                                            'Total Expenses',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.text,
                                            ),
                                          ),
                                          Text(
                                            'Ksh ${totalExpenses.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: totalExpenses == 0.0
                                                  ? Colors.black
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(height: 24),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Net Profit',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.text,
                                            ),
                                          ),
                                          Text(
                                            'Ksh ${totalProfit.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }

                      final batch = displayedBatches[index];
                      final sum =
                          summariesByBatchId[batch.id] ?? _BatchSummary();
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          batch.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.text,
                                          ),
                                        ),
                                        Text(
                                          batch.birdType.toUpperCase(),
                                          style: TextStyle(
                                            color: CustomColors.text
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Ksh ${batch.pricePerBird.toStringAsFixed(2)} per bird',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: CustomColors.text
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${batch.totalChickens} Birds',
                                    style: TextStyle(
                                      color: CustomColors.text,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (sum.feedsByType.isNotEmpty) ...[
                                    Text(
                                      'Feeds Used',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.text,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(
                                                0.1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(11),
                                                  ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'Feed Type',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Quantity',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Price/kg',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Total',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ...sum.feedsByType.entries.map((
                                            feed,
                                          ) {
                                            final price =
                                                (inventoryMap[feed
                                                            .key]?['price']
                                                        as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final total = feed.value * price;
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(feed.key),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${feed.value.toStringAsFixed(2)} kg',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Ksh ${price.toStringAsFixed(2)}',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Ksh ${total.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                  if (sum.vaccineQuantities.isNotEmpty) ...[
                                    Text(
                                      'Vaccines Used',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.text,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(
                                                0.1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(11),
                                                  ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'Vaccine',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Quantity',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Price/L',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Total',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ...sum.vaccineQuantities.entries.map((
                                            vaccine,
                                          ) {
                                            final price =
                                                (inventoryMap[vaccine
                                                            .key]?['price']
                                                        as num?)
                                                    ?.toDouble() ??
                                                0.0;
                                            final total = vaccine.value * price;
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(vaccine.key),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${vaccine.value.toStringAsFixed(2)} L',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Ksh ${price.toStringAsFixed(2)}',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Ksh ${total.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                  // Financial Summary Section
                                  const SizedBox(height: 24),
                                  Text(
                                    'financial_summary'.tr(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Sales breakdown
                                  // Always show sales section even if 0
                                  Text(
                                    'total_sales'.tr(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  ...sum.salesByCategory.entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              entry.key.tr(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'KES ${entry.value.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'total_income'.tr(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'KES ${sum.totalSales.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Expenses breakdown
                                  Text(
                                    'expenses'.tr(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  ...sum.expensesByCategory.entries.map((
                                    entry,
                                  ) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              entry.key.tr(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'KES ${entry.value.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: entry.value == 0.0
                                                  ? Colors.black
                                                  : Colors.red[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'total_expenses'.tr(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'KES ${sum.totalExpenses.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: sum.totalExpenses == 0.0
                                              ? Colors.black
                                              : Colors.red[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Net Profit/Loss
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'net_profit_loss'.tr(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'KES ${(sum.totalSales - sum.totalExpenses).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (sum.totalMortality > 0) ...[
                                    Text(
                                      'Mortality',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.text,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.red.withOpacity(0.2),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(
                                                0.1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(11),
                                                  ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'Bird Type',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Quantity',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Price/Bird',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Total Loss',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  color: Colors.red.withOpacity(
                                                    0.2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    batch.birdType,
                                                    style: TextStyle(
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${sum.totalMortality} birds',
                                                    style: TextStyle(
                                                      color:
                                                          sum.totalMortality > 0
                                                          ? Colors.red
                                                          : CustomColors.text,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Ksh ${batch.pricePerBird.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      color: CustomColors.text
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Ksh ${(batch.pricePerBird * sum.totalMortality).toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      color:
                                                          sum.totalMortality > 0
                                                          ? Colors.red
                                                          : CustomColors.text,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Download button at bottom
                if (summariesByBatchId.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _exportPdf,
                        icon: const Icon(Icons.download),
                        label: Text('download_pdf'.tr()),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  /// Get list of batches to display based on selected batch
  List<Batch> _getDisplayedBatches() {
    if (selectedBatch != null) {
      return [selectedBatch!];
    }
    return batches;
  }

  /// Get count of items to display in list (batches + optional grand total)
  int _getDisplayedBatchCount() {
    final displayedBatches = _getDisplayedBatches();
    // Add 1 for grand total if viewing all batches and there are multiple batches
    if (selectedBatch == null && batches.length > 1) {
      return displayedBatches.length + 1;
    }
    return displayedBatches.length;
  }
}

class _BatchSummary {
  int totalChickens = 0;
  int reductions = 0;
  Map<String, int> reductionCounts = {};
  Map<String, double> materialUsage = {};
  int totalEggs = 0;
  double feedsUsed = 0;
  double totalSales = 0;
  double totalExpenses = 0;
  double totalProfit = 0.0;
  Map<String, double> salesByCategory = {'eggs': 0.0, 'chickens': 0.0};
  Map<String, double> expensesByCategory = {
    'feeds': 0.0,
    'vaccines': 0.0,
    'other_materials': 0.0,
    'mortality': 0.0,
    'bird_cost': 0.0,
    'livestock_losses': 0.0,
    'losses_died': 0.0,
    'losses_stolen': 0.0,
    'losses_curled': 0.0,
  };
  List<String> notes = [];
  int totalMortality = 0;
  int totalVaccinations = 0;
  Map<String, double> feedsByType = {};
  Map<String, double> vaccineQuantities = {};
  double totalFeedKg = 0.0;

  void addFromReport(Map<String, dynamic> report) {
    if (report['chickens'] != null) {
      totalChickens = (report['chickens'] as num).toInt();
    }
    if (report['reductions'] != null) {
      reductions += (report['reductions'] as num).toInt();

      if (report['reductionReasons'] != null) {
        final reasons = report['reductionReasons'] as Map<String, dynamic>;
        reasons.forEach((reason, count) {
          final countValue = (count as num).toInt();
          reductionCounts[reason] = (reductionCounts[reason] ?? 0) + countValue;
          if (reason == 'mortality') {
            totalMortality += countValue;
          }
        });
      }
    }

    if (report['materialUsage'] != null) {
      final materials = report['materialUsage'] as Map<String, dynamic>;
      materials.forEach((material, amount) {
        materialUsage[material] =
            (materialUsage[material] ?? 0) + (amount as num).toDouble();
      });
    }

    if (report['eggsCollected'] != null) {
      totalEggs += (report['eggsCollected'] as num).toInt();
    }

    if (report['feedsUsed'] != null) {
      feedsUsed += (report['feedsUsed'] as num).toDouble();
      totalFeedKg += (report['feedsUsed'] as num).toDouble();

      if (report['feedType'] != null) {
        final type = report['feedType'] as String;
        feedsByType[type] =
            (feedsByType[type] ?? 0) + (report['feedsUsed'] as num).toDouble();
      }
    }

    if (report['vaccinations'] != null) {
      totalVaccinations += (report['vaccinations'] as num).toInt();

      if (report['vaccineQuantities'] != null) {
        final quantities = report['vaccineQuantities'] as Map<String, dynamic>;
        quantities.forEach((vaccine, amount) {
          vaccineQuantities[vaccine] =
              (vaccineQuantities[vaccine] ?? 0) + (amount as num).toDouble();
        });
      }
    }

    if (report['sales'] != null) {
      final sales = report['sales'] as num;
      totalSales += sales.toDouble();

      if (report['salesCategory'] != null) {
        final category = report['salesCategory'] as String;
        salesByCategory[category] =
            (salesByCategory[category] ?? 0) + sales.toDouble();
      }
    }

    if (report['expenses'] != null) {
      final expenses = report['expenses'] as num;
      totalExpenses += expenses.toDouble();

      if (report['expenseCategory'] != null) {
        final category = report['expenseCategory'] as String;
        expensesByCategory[category] =
            (expensesByCategory[category] ?? 0) + expenses.toDouble();
      }
    }

    if (report['notes'] != null && report['notes'].isNotEmpty) {
      notes.add(report['notes'] as String);
    }
  }
}
