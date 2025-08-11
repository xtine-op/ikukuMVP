import 'package:flutter/material.dart';
import '../data/daily_record_model.dart';
import '../../../shared/services/supabase_service.dart';
import '../../batches/data/batch_model.dart';
import '../data/batch_record_model.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class RecordDetailPage extends StatefulWidget {
  final DailyRecord record;
  const RecordDetailPage({super.key, required this.record});

  @override
  State<RecordDetailPage> createState() {
    print('RecordDetailPage - createState called with record: ${record.id}');
    return _RecordDetailPageState();
  }
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  List<BatchRecord> batchRecords = [];
  Batch? batch;
  bool loading = true;

  @override
  void initState() {
    print('RecordDetailPage - initState called');
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    print('RecordDetailPage - _fetchDetails called');
    print('RecordDetailPage - widget.record.id: ${widget.record.id}');
    print(
      'RecordDetailPage - widget.record.recordDate: ${widget.record.recordDate}',
    );
    print('RecordDetailPage - widget.record.userId: ${widget.record.userId}');
    setState(() => loading = true);
    final batchRecordsRaw = await SupabaseService()
        .fetchBatchRecordsForDailyRecord(widget.record.id);

    // Debug: Print the raw data from database
    print('RecordDetailPage - Raw batch records from DB: $batchRecordsRaw');

    if (batchRecordsRaw.isNotEmpty) {
      batchRecords = batchRecordsRaw
          .map((e) => BatchRecord.fromJson(e))
          .toList();

      // Debug: Print the parsed batch records
      for (final record in batchRecords) {
        print('RecordDetailPage - Parsed batch record:');
        print('  feedsUsed: ${record.feedsUsed}');
        print('  vaccinesUsed: ${record.vaccinesUsed}');
        print('  otherMaterialsUsed: ${record.otherMaterialsUsed}');
      }

      // Fetch batch info for the first batch (assuming one batch per record for now)
      final batchId = batchRecords.first.batchId;
      final batchesRaw = await SupabaseService().fetchBatches(
        widget.record.userId,
      );
      batch = batchesRaw
          .map((e) => Batch.fromJson(e))
          .firstWhere(
            (b) => b.id == batchId,
            orElse: () => Batch.empty(widget.record.userId),
          );
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    print('RecordDetailPage - build called, loading: $loading');
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final dateStr = DateFormat('d MMMM yyyy').format(widget.record.recordDate);
    return Scaffold(
      appBar: AppBar(title: Text('confirm'.tr())),
      body: batch == null || batchRecords.isEmpty
          ? Center(child: Text('no_details_found'.tr()))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9E5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${batch!.name}'s Farm report",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              dateStr,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.layers,
                              size: 18,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${batch!.name} - ${batch!.birdType}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ...batchRecords
                      .map((rec) => _BatchRecordSectionUI(rec))
                      .toList(),
                  const SizedBox(height: 16),
                  // Footer
                  Center(
                    child: Column(
                      children: [
                        Text('this_report_prepared_by'.tr()),
                        Text(
                          'Type here on ${DateFormat('dd/MM/yyyy').format(widget.record.createdAt)} at ${DateFormat('jm').format(widget.record.createdAt)}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Finish Reporting Button (disabled, for display only)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF9C846),
                        disabledBackgroundColor: const Color(0xFFB6D96A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      child: Text('finish_reporting'.tr()),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _BatchRecordSection extends StatelessWidget {
  final BatchRecord rec;
  const _BatchRecordSection(this.rec);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionCard(
          title: 'BIRDS',
          items: [
            _SectionItem(label: 'Sold', value: rec.chickensSold.toString()),
            _SectionItem(label: 'Died', value: rec.chickensDied.toString()),
            _SectionItem(label: 'Curled', value: rec.chickensCurled.toString()),
            _SectionItem(label: 'Stolen', value: rec.chickensStolen.toString()),
          ],
        ),
        _SectionCard(
          title: 'EGGS',
          items: [
            _SectionItem(
              label: 'Collected',
              value: (rec.eggsCollected ?? 0).toString(),
            ),
            _SectionItem(
              label: 'Small',
              value: (rec.eggsSmall ?? 0).toString(),
            ),
            _SectionItem(
              label: 'Deformed',
              value: (rec.eggsDeformed ?? 0).toString(),
            ),
            _SectionItem(
              label: 'Standard',
              value: (rec.eggsStandard ?? 0).toString(),
            ),
          ],
        ),
        _SectionCard(
          title: 'FEEDS USED',
          items: [
            _SectionItem(
              label: 'Feed Used (Kg)',
              value: (rec.feedUsedKg ?? 0).toString(),
            ),
          ],
        ),
        _SectionCard(
          title: 'VACCINES',
          items: [
            _SectionItem(
              label: 'Vaccines Given',
              value: rec.vaccinesGiven ?? '-',
            ),
          ],
        ),
        if (rec.notes != null && rec.notes!.isNotEmpty)
          _SectionCard(
            title: 'NOTES',
            items: [_SectionItem(label: 'Notes', value: rec.notes!)],
          ),
        const SizedBox(height: 16),
      ],
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
                  Text(item.label, style: const TextStyle(fontSize: 15)),
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
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

// Add a new UI section for the batch record to match the attached UI
class _BatchRecordSectionUI extends StatelessWidget {
  final BatchRecord rec;
  const _BatchRecordSectionUI(this.rec);

  @override
  Widget build(BuildContext context) {
    final birdsItems = <_SectionItem>[];
    if (rec.chickensSold != 0)
      birdsItems.add(
        _SectionItem(label: 'sold'.tr(), value: rec.chickensSold.toString()),
      );
    if (rec.chickensDied != 0)
      birdsItems.add(
        _SectionItem(label: 'died'.tr(), value: rec.chickensDied.toString()),
      );
    if (rec.chickensCurled != 0)
      birdsItems.add(
        _SectionItem(
          label: 'curled'.tr(),
          value: rec.chickensCurled.toString(),
        ),
      );
    if (rec.chickensStolen != 0)
      birdsItems.add(
        _SectionItem(
          label: 'stolen'.tr(),
          value: rec.chickensStolen.toString(),
        ),
      );

    final eggsItems = <_SectionItem>[];
    if ((rec.eggsCollected ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'collected'.tr(),
          value: (rec.eggsCollected ?? 0).toString(),
        ),
      );
    if ((rec.eggsBroken ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'broken'.tr(),
          value: (rec.eggsBroken ?? 0).toString(),
        ),
      );
    if ((rec.eggsSmall ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'small'.tr(),
          value: (rec.eggsSmall ?? 0).toString(),
        ),
      );
    if ((rec.eggsDeformed ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'deformed'.tr(),
          value: (rec.eggsDeformed ?? 0).toString(),
        ),
      );
    if ((rec.eggsStandard ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'standard'.tr(),
          value: (rec.eggsStandard ?? 0).toString(),
        ),
      );

    final feedsItems = <_SectionItem>[];
    print('_BatchRecordSectionUI - rec.feedsUsed: ${rec.feedsUsed}');
    print(
      '_BatchRecordSectionUI - rec.feedsUsed.isNotEmpty: ${rec.feedsUsed.isNotEmpty}',
    );
    if (rec.feedsUsed.isNotEmpty) {
      feedsItems.addAll(
        rec.feedsUsed
            .where((f) => (f.quantity) > 0)
            .map((f) => _SectionItem(label: f.name, value: '${f.quantity} Kg')),
      );
    } else if ((rec.feedUsedKg ?? 0) != 0) {
      feedsItems.add(
        _SectionItem(
          label: 'Feed Used (Kg)',
          value: (rec.feedUsedKg ?? 0).toString(),
        ),
      );
    }

    final vaccinesItems = <_SectionItem>[];
    print('_BatchRecordSectionUI - rec.vaccinesUsed: ${rec.vaccinesUsed}');
    print(
      '_BatchRecordSectionUI - rec.vaccinesUsed.isNotEmpty: ${rec.vaccinesUsed.isNotEmpty}',
    );
    if (rec.vaccinesUsed.isNotEmpty) {
      vaccinesItems.addAll(
        rec.vaccinesUsed
            .where((v) => (v.quantity) > 0)
            .map(
              (v) => _SectionItem(label: v.name, value: '${v.quantity} Lit'),
            ),
      );
    } else if ((rec.vaccinesGiven != null && rec.vaccinesGiven!.isNotEmpty)) {
      vaccinesItems.add(
        _SectionItem(label: 'Vaccines Given', value: rec.vaccinesGiven!),
      );
    }

    final sawdustItems = <_SectionItem>[];
    if (rec.sawdustInStore != null)
      sawdustItems.add(
        _SectionItem(
          label: 'in_store'.tr(),
          value: rec.sawdustInStore.toString(),
        ),
      );
    if (rec.sawdustUsed != null)
      sawdustItems.add(
        _SectionItem(label: 'used'.tr(), value: rec.sawdustUsed.toString()),
      );
    if (rec.sawdustRemaining != null)
      sawdustItems.add(
        _SectionItem(
          label: 'remaining'.tr(),
          value: rec.sawdustRemaining.toString(),
        ),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (birdsItems.isNotEmpty)
          _SectionCardUI(
            title: 'birds'.tr().toUpperCase(),
            edit: true,
            items: birdsItems,
          ),
        if (eggsItems.isNotEmpty)
          _SectionCardUI(
            title: 'eggs'.tr().toUpperCase(),
            edit: true,
            items: eggsItems,
          ),
        if (feedsItems.isNotEmpty)
          _SectionCardUI(
            title: 'feeds_used'.tr().toUpperCase(),
            edit: true,
            items: feedsItems,
          ),
        if (vaccinesItems.isNotEmpty)
          _SectionCardUI(
            title: 'vaccines'.tr().toUpperCase(),
            edit: true,
            items: vaccinesItems,
          ),
        if (sawdustItems.isNotEmpty)
          _SectionCardUI(
            title: 'sawdust'.tr().toUpperCase(),
            edit: true,
            items: sawdustItems,
          ),
      ],
    );
  }
}

class _SectionCardUI extends StatelessWidget {
  final String title;
  final List<_SectionItem> items;
  final bool edit;
  const _SectionCardUI({
    required this.title,
    required this.items,
    this.edit = false,
  });

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              if (edit)
                GestureDetector(
                  onTap: () {}, // TODO: Implement edit navigation
                  child: Text(
                    'edit_items'.tr(),
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.label, style: const TextStyle(fontSize: 15)),
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
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
