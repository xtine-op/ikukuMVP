import 'package:flutter/material.dart';
import '../../batches/data/batch_model.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';
import 'package:intl/intl.dart';
import '../../../shared/services/supabase_service.dart';
import '../../records/data/batch_record_model.dart';

class ReportDetailPage extends StatefulWidget {
  final Map<String, dynamic> report;
  final Map<String, dynamic>? batch;
  const ReportDetailPage({super.key, required this.report, this.batch});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  Map<String, dynamic>? batch;
  List<Map<String, dynamic>> batchRecords = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    batch = widget.batch;
    _fetchBatchRecords();
  }

  Future<void> _fetchBatchRecords() async {
    setState(() => loading = true);
    try {
      final report = widget.report;
      final batchId = report['batch_id'] ?? report['batchId'] ?? batch?['id'];
      final dailyRecordId = report['id'] ?? report['daily_record_id'];
      List<Map<String, dynamic>> records = [];
      if (batchId != null && dailyRecordId != null) {
        records = await SupabaseService().fetchBatchRecordsForDailyRecord(
          dailyRecordId,
        );
        records = records.where((r) => r['batch_id'] == batchId).toList();
      }
      setState(() {
        batchRecords = records;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load batch records: $e';
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
    final batchName = batch?['name'] ?? '';
    final batchType = batch?['bird_type'] ?? '';
    final rawDate =
        report['record_date'] ?? report['date'] ?? report['created_at'] ?? '';
    String formattedDate = '';
    if (rawDate is String && rawDate.isNotEmpty) {
      try {
        final dt = DateTime.parse(rawDate);
        formattedDate = DateFormat('d MMM yyyy').format(dt);
      } catch (_) {
        formattedDate = rawDate;
      }
    } else if (rawDate is DateTime) {
      formattedDate = DateFormat('d MMM yyyy').format(rawDate);
    }
    final rec = batchRecords.isNotEmpty ? batchRecords.first : null;
    BatchRecord? batchRecordModel;
    if (rec != null) {
      try {
        batchRecordModel = BatchRecord.fromJson(rec);
      } catch (_) {}
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Confirm',
          style: TextStyle(color: CustomColors.primary),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.background,
        elevation: 0,
      ),
      backgroundColor: CustomColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.lightYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$batchName's Farm report",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: CustomColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formattedDate,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.layers, size: 16, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(
                        '$batchName - $batchType',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Birds Section
            _SectionCard(
              title:
                  'BIRDS${batchType.isNotEmpty ? '- ${batchType.toString().toUpperCase()}' : ''}',
              items: [
                _SectionItem(
                  label: 'Sold',
                  value: (rec?['chickens_sold'] ?? 0).toString(),
                ),
                _SectionItem(
                  label: 'Died',
                  value: (rec?['chickens_died'] ?? 0).toString(),
                ),
                _SectionItem(
                  label: 'Curled',
                  value: (rec?['chickens_curled'] ?? 0).toString(),
                ),
                _SectionItem(
                  label: 'Stolen',
                  value: (rec?['chickens_stolen'] ?? 0).toString(),
                ),
              ],
            ),
            // Eggs Section (only if not broiler)
            if (batchType.toString().toLowerCase() != 'broiler' && rec != null)
              _SectionCard(
                title: 'EGGS',
                items: [
                  _SectionItem(
                    label: 'Collected',
                    value: (rec['eggs_collected'] ?? 0).toString(),
                  ),
                  _SectionItem(
                    label: 'Broken',
                    value: (rec['eggs_broken'] ?? 0).toString(),
                  ),
                  _SectionItem(
                    label: 'Small',
                    value: (rec['eggs_small'] ?? 0).toString(),
                  ),
                  _SectionItem(
                    label: 'Deformed',
                    value: (rec['eggs_deformed'] ?? 0).toString(),
                  ),
                  _SectionItem(
                    label: 'Big',
                    value: (rec['eggs_standard'] ?? 0).toString(),
                  ),
                ],
              ),
            // Feeds Used Section
            _SectionCard(
              title: 'FEEDS USED',
              items: [
                if (batchRecordModel != null &&
                    batchRecordModel.feedsUsed.isNotEmpty)
                  ...batchRecordModel.feedsUsed.map(
                    (f) =>
                        _SectionItem(label: f.name, value: '${f.quantity} Kg'),
                  ),
                if ((batchRecordModel == null ||
                        batchRecordModel.feedsUsed.isEmpty) &&
                    rec != null &&
                    rec['feeds_used'] != null &&
                    rec['feeds_used'] is List)
                  ...List<Map<String, dynamic>>.from(rec['feeds_used']).map(
                    (f) => _SectionItem(
                      label: f['name'] ?? '',
                      value: '${f['quantity'] ?? 0} Kg',
                    ),
                  ),
              ],
            ),
            // Vaccines Section
            _SectionCard(
              title: 'VACCINES',
              items: [
                if (batchRecordModel != null &&
                    batchRecordModel.vaccinesUsed.isNotEmpty)
                  ...batchRecordModel.vaccinesUsed.map(
                    (v) =>
                        _SectionItem(label: v.name, value: '${v.quantity} Lit'),
                  ),
                if ((batchRecordModel == null ||
                        batchRecordModel.vaccinesUsed.isEmpty) &&
                    rec != null &&
                    rec['vaccines_used'] != null &&
                    rec['vaccines_used'] is List)
                  ...List<Map<String, dynamic>>.from(rec['vaccines_used']).map(
                    (v) => _SectionItem(
                      label: v['name'] ?? '',
                      value: '${v['quantity'] ?? 0} Lit',
                    ),
                  ),
              ],
            ),
            // Sawdust Section
            _SectionCard(
              title: 'SAWDUST',
              items: [
                _SectionItem(
                  label: 'In store',
                  value: '${rec?['sawdust_in_store'] ?? 0}kg',
                ),
                _SectionItem(
                  label: 'Used',
                  value: '${rec?['sawdust_used'] ?? 0}kg',
                ),
                _SectionItem(
                  label: 'Remaining',
                  value: '${rec?['sawdust_remaining'] ?? 0}kg',
                ),
              ],
            ),
            // Other Materials Used Section
            _SectionCard(
              title: 'OTHER MATERIALS USED',
              items: [
                if (batchRecordModel != null &&
                    batchRecordModel.otherMaterialsUsed.isNotEmpty)
                  ...batchRecordModel.otherMaterialsUsed.map(
                    (m) => _SectionItem(
                      label: m.name,
                      value: m.unit != null
                          ? '${m.quantity} ${m.unit}'
                          : '${m.quantity}',
                    ),
                  ),
                if ((batchRecordModel == null ||
                        batchRecordModel.otherMaterialsUsed.isEmpty) &&
                    rec != null &&
                    rec['other_materials_used'] != null &&
                    rec['other_materials_used'] is List)
                  ...List<Map<String, dynamic>>.from(
                    rec['other_materials_used'],
                  ).map(
                    (m) => _SectionItem(
                      label: m['name'] ?? '',
                      value: m['unit'] != null
                          ? '${m['quantity']} ${m['unit']}'
                          : '${m['quantity'] ?? ''}',
                    ),
                  ),
              ],
            ),
            // Notes Section
            if (rec != null &&
                rec['notes'] != null &&
                rec['notes'].toString().isNotEmpty)
              _SectionCard(
                title: 'NOTES',
                items: [_SectionItem(label: '', value: rec['notes'])],
              ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: CustomColors.buttonGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'CLOSE REPORT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<_SectionItem> items;
  const _SectionCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item.label,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      item.value,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: CustomColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionItem {
  final String label;
  final String value;
  const _SectionItem({required this.label, required this.value});
}
