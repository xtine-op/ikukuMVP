import 'package:flutter/material.dart';
import '../../batches/data/batch_model.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../shared/services/supabase_service.dart';

class ReportDetailPage extends StatefulWidget {
  final Map<String, dynamic> report;
  const ReportDetailPage({super.key, required this.report});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  Batch? batch;
  InventoryItem? feed;
  InventoryItem? vaccine;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchRelatedData();
  }

  Future<void> _fetchRelatedData() async {
    setState(() => loading = true);
    try {
      final report = widget.report;
      final batchId = report['batch_id'] ?? report['batchId'];
      final feedName =
          report['feed'] ?? report['feed_name'] ?? report['feed_type'];
      final vaccineName =
          report['vaccine'] ??
          report['vaccine_name'] ??
          report['vaccine_type'] ??
          report['vaccines_given'];
      final userId = report['user_id'] ?? report['userId'];
      Batch? batchObj;
      InventoryItem? feedObj;
      InventoryItem? vaccineObj;
      if (batchId != null && userId != null) {
        final batches = await SupabaseService().fetchBatches(userId);
        batchObj =
            batches
                .map((e) => Batch.fromJson(e))
                .where((b) => b.id == batchId)
                .cast<Batch?>()
                .isNotEmpty
            ? batches
                  .map((e) => Batch.fromJson(e))
                  .firstWhere((b) => b.id == batchId)
            : null;
      }
      if (feedName != null && userId != null) {
        final inventory = await SupabaseService().fetchInventory(userId);
        final feeds = inventory
            .map((e) => InventoryItem.fromJson(e))
            .where((i) => i.category == 'feed')
            .toList();
        feedObj = feeds.where((f) => f.name == feedName).isNotEmpty
            ? feeds.firstWhere((f) => f.name == feedName)
            : null;
      }
      if (vaccineName != null && userId != null) {
        final inventory = await SupabaseService().fetchInventory(userId);
        final vaccines = inventory
            .map((e) => InventoryItem.fromJson(e))
            .where((i) => i.category == 'vaccine')
            .toList();
        vaccineObj = vaccines.where((v) => v.name == vaccineName).isNotEmpty
            ? vaccines.firstWhere((v) => v.name == vaccineName)
            : null;
      }
      setState(() {
        batch = batchObj;
        feed = feedObj;
        vaccine = vaccineObj;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load related data: $e';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final report = widget.report;
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Report Details')),
        body: Center(child: Text(error!)),
      );
    }
    final batchName =
        batch?.name ??
        report['batch_name'] ??
        report['batch'] ??
        report['batch_name_from_batch'] ??
        '';
    final batchType =
        batch?.birdType ??
        report['batch_type'] ??
        report['bird_type'] ??
        report['batch_type_from_batch'] ??
        '';
    final dateRecorded =
        report['date'] ?? report['record_date'] ?? report['created_at'] ?? '';
    final chickenReduced =
        report['chicken_reduced'] ??
        report['chickens_reduced'] ??
        report['chickens_died'] ??
        report['chickens_curled'] ??
        report['chickens_stolen'] ??
        '';
    final reductionReason =
        report['reduction_reason'] ??
        report['reductionreason'] ??
        report['reason'] ??
        (report['chickens_died'] != null
            ? 'death'
            : report['chickens_curled'] != null
            ? 'curled'
            : report['chickens_stolen'] != null
            ? 'stolen'
            : '');
    final feedType =
        feed?.name ??
        report['feed_type'] ??
        report['feed_used'] ??
        report['feed_name'] ??
        report['feed'] ??
        '';
    final feedKgs =
        report['feed_kgs'] ??
        report['feed_used_kg'] ??
        report['feed_amount'] ??
        '';
    final feedsRemaining =
        feed?.quantity.toString() ??
        report['feed_remaining'] ??
        report['feed_stock'] ??
        report['feed_balance'] ??
        '';
    final vaccineType =
        vaccine?.name ??
        report['vaccine_type'] ??
        report['vaccines_given'] ??
        report['vaccine_used'] ??
        report['vaccine'] ??
        '';
    final vaccineAmount =
        report['vaccine_amount'] ??
        report['vaccine_used'] ??
        report['vaccine_amount_used'] ??
        '';
    final otherItems =
        report['other_items'] ??
        report['other_materials'] ??
        report['materials_used'] ??
        [];
    final notes = report['notes'] ?? report['additional_notes'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(batchName.isNotEmpty ? batchName : 'Batch Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Batch Name: $batchName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Batch Type: $batchType'),
            const SizedBox(height: 8),
            Text('Date Recorded: $dateRecorded'),
            const SizedBox(height: 8),
            Text('Chicken Reduced: $chickenReduced'),
            const SizedBox(height: 8),
            Text('Reason for Reduction: $reductionReason'),
            const SizedBox(height: 8),
            Text('Type of Feeds Used: $feedType'),
            const SizedBox(height: 8),
            Text('Kgs of Feeds Used: $feedKgs'),
            const SizedBox(height: 8),
            Text('Feeds Remaining: $feedsRemaining'),
            const SizedBox(height: 8),
            Text('Vaccine Used: $vaccineType'),
            const SizedBox(height: 8),
            Text('Amount of Vaccine Used: $vaccineAmount'),
            const SizedBox(height: 8),
            Text('Other Items Used:'),
            if (otherItems is List && otherItems.isNotEmpty)
              ...otherItems.map<Widget>((item) {
                if (item is Map<String, dynamic>) {
                  return Text(
                    '- ${item['name'] ?? item['item_name'] ?? ''}: ${item['quantity'] ?? item['qty'] ?? ''}',
                  );
                } else if (item is String) {
                  return Text('- $item');
                } else {
                  return const SizedBox.shrink();
                }
              }),
            if (otherItems is! List || otherItems.isEmpty) const Text('- None'),
            const SizedBox(height: 8),
            Text('Additional Notes: $notes'),
          ],
        ),
      ),
    );
  }
}
