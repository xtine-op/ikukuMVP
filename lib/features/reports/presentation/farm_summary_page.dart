import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
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
  List<Batch> batches = [];
  Map<String, _BatchSummary> summariesByBatchId = {};

  @override
  void initState() {
    super.initState();
    // Default to last 7 days
    final now = DateTime.now();
    selectedRange = DateTimeRange(
      start: now.subtract(const Duration(days: 7)),
      end: now.add(const Duration(days: 1)),
    );
    _loadData();
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
    final user = Supabase.instance.client.auth.currentUser;
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
      final inventoryMap = <String, Map<String, dynamic>>{};
      for (final item in inventoryItems) {
        inventoryMap[item['name']] = item;
      }

      // Aggregate per batch
      final Map<String, _BatchSummary> tmp = {};
      for (final br in batchRecords) {
        final batchId = br['batch_id'] as String?;
        if (batchId == null) continue;
        final feedsUsed = br['feeds_used'];
        final chickensDied = (br['chickens_died'] as int?) ?? 0;
        final vaccinesUsed = br['vaccines_used'];
        final otherMaterialsUsed = br['other_materials_used'];

        tmp.putIfAbsent(batchId, () => _BatchSummary());
        final sum = tmp[batchId]!;

        // Sum feeds_used list quantities and calculate expenses
        if (feedsUsed is List) {
          for (final item in feedsUsed) {
            if (item is Map && item['quantity'] != null) {
              final qty = (item['quantity'] as num).toDouble();
              final name = item['name'] as String?;
              sum.totalFeedKg += qty;

              // Calculate expenses for feeds
              if (name != null && inventoryMap.containsKey(name)) {
                final price =
                    (inventoryMap[name]!['price'] as num?)?.toDouble() ?? 0.0;
                sum.totalExpenses += qty * price;
              }
            }
          }
        }

        // Calculate expenses for vaccines
        if (vaccinesUsed is List) {
          sum.totalVaccinations += vaccinesUsed.length;
          for (final item in vaccinesUsed) {
            if (item is Map &&
                item['quantity'] != null &&
                item['name'] != null) {
              final qty = (item['quantity'] as num).toDouble();
              final name = item['name'] as String;
              if (inventoryMap.containsKey(name)) {
                final price =
                    (inventoryMap[name]!['price'] as num?)?.toDouble() ?? 0.0;
                sum.totalExpenses += qty * price;
              }
            }
          }
        }

        // Calculate expenses for other materials
        if (otherMaterialsUsed is List) {
          for (final item in otherMaterialsUsed) {
            if (item is Map &&
                item['quantity'] != null &&
                item['name'] != null) {
              final qty = (item['quantity'] as num).toDouble();
              final name = item['name'] as String;
              if (inventoryMap.containsKey(name)) {
                final price =
                    (inventoryMap[name]!['price'] as num?)?.toDouble() ?? 0.0;
                sum.totalExpenses += qty * price;
              }
            }
          }
        }

        // Sum mortality
        sum.totalMortality += chickensDied;
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
                  'Feeds Used (kg)',
                  'Mortality',
                  'Vaccinations',
                  'Total Expenses',
                ],
                data: batches.map((b) {
                  final s = summariesByBatchId[b.id] ?? _BatchSummary();
                  return [
                    b.name,
                    s.totalFeedKg.toStringAsFixed(2),
                    s.totalMortality.toString(),
                    s.totalVaccinations.toString(),
                    s.totalExpenses.toStringAsFixed(2),
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
              Navigator.of(context).pop();
            } else {
              // Ensure we can always go back to dashboard
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: summariesByBatchId.isEmpty ? null : _exportPdf,
            tooltip: 'Download Farm Summary',
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedRange == null
                              ? ''
                              : '${DateFormat.yMMMd().format(selectedRange!.start)} - ${DateFormat.yMMMd().format(selectedRange!.end.subtract(const Duration(days: 1)))}',
                          style: TextStyle(color: CustomColors.text),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _pickDateRange,
                        icon: const Icon(Icons.date_range),
                        label: Text('select_dates'.tr()),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: batches.length,
                    itemBuilder: (context, index) {
                      final batch = batches[index];
                      final sum =
                          summariesByBatchId[batch.id] ?? _BatchSummary();
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(batch.name),
                          subtitle: Text(batch.birdType),
                          trailing: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 120),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${'feeds_used'.tr()}: ${sum.totalFeedKg.toStringAsFixed(2)} kg',
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${'mortality'.tr()}: ${sum.totalMortality}',
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${'vaccinations'.tr()}: ${sum.totalVaccinations}',
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${'total_expenses'.tr()}: ${sum.totalExpenses.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Download button at bottom
                if (summariesByBatchId.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
}

class _BatchSummary {
  double totalFeedKg = 0.0;
  int totalMortality = 0;
  int totalVaccinations = 0;
  double totalExpenses = 0.0;
}
