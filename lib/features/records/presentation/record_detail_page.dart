import 'package:flutter/material.dart';
import '../data/daily_record_model.dart';
import '../../../shared/services/supabase_service.dart';
import '../../batches/data/batch_model.dart';
import '../data/batch_record_model.dart';
import 'package:intl/intl.dart';

class RecordDetailPage extends StatefulWidget {
  final DailyRecord record;
  const RecordDetailPage({super.key, required this.record});

  @override
  State<RecordDetailPage> createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  List<BatchRecord> batchRecords = [];
  Batch? batch;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    setState(() => loading = true);
    final batchRecordsRaw = await SupabaseService()
        .fetchBatchRecordsForDailyRecord(widget.record.id);
    if (batchRecordsRaw.isNotEmpty) {
      batchRecords = batchRecordsRaw
          .map((e) => BatchRecord.fromJson(e))
          .toList();
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
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final dateStr = DateFormat('d MMMM yyyy').format(widget.record.recordDate);
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm')),
      body: batch == null || batchRecords.isEmpty
          ? const Center(child: Text('No details found for this record.'))
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
                        const Text('This report was prepared by'),
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      child: const Text('FINISH REPORTING'),
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
        _SectionItem(label: 'Sold', value: rec.chickensSold.toString()),
      );
    if (rec.chickensDied != 0)
      birdsItems.add(
        _SectionItem(label: 'Died', value: rec.chickensDied.toString()),
      );
    if (rec.chickensCurled != 0)
      birdsItems.add(
        _SectionItem(label: 'Curled', value: rec.chickensCurled.toString()),
      );
    if (rec.chickensStolen != 0)
      birdsItems.add(
        _SectionItem(label: 'Stolen', value: rec.chickensStolen.toString()),
      );

    final eggsItems = <_SectionItem>[];
    if ((rec.eggsCollected ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'Collected',
          value: (rec.eggsCollected ?? 0).toString(),
        ),
      );
    if ((rec.eggsBroken ?? 0) != 0)
      eggsItems.add(
        _SectionItem(label: 'Broken', value: (rec.eggsBroken ?? 0).toString()),
      );
    if ((rec.eggsSmall ?? 0) != 0)
      eggsItems.add(
        _SectionItem(label: 'Small', value: (rec.eggsSmall ?? 0).toString()),
      );
    if ((rec.eggsDeformed ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'Deformed',
          value: (rec.eggsDeformed ?? 0).toString(),
        ),
      );
    if ((rec.eggsStandard ?? 0) != 0)
      eggsItems.add(
        _SectionItem(
          label: 'Standard',
          value: (rec.eggsStandard ?? 0).toString(),
        ),
      );

    final feedsItems = <_SectionItem>[];
    if (rec.feedsUsed.isNotEmpty) {
      feedsItems.addAll(
        rec.feedsUsed.map(
          (f) => _SectionItem(label: f.name, value: '${f.quantity} Kg'),
        ),
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
    if (rec.vaccinesUsed.isNotEmpty) {
      vaccinesItems.addAll(
        rec.vaccinesUsed.map(
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
        _SectionItem(label: 'In store', value: rec.sawdustInStore.toString()),
      );
    if (rec.sawdustUsed != null)
      sawdustItems.add(
        _SectionItem(label: 'Used', value: rec.sawdustUsed.toString()),
      );
    if (rec.sawdustRemaining != null)
      sawdustItems.add(
        _SectionItem(
          label: 'Remaining',
          value: rec.sawdustRemaining.toString(),
        ),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (birdsItems.isNotEmpty)
          _SectionCardUI(title: 'BIRDS- LAYERS', edit: true, items: birdsItems),
        if (eggsItems.isNotEmpty)
          _SectionCardUI(title: 'EGGS', edit: true, items: eggsItems),
        if (feedsItems.isNotEmpty)
          _SectionCardUI(title: 'FEEDS USED', edit: true, items: feedsItems),
        if (vaccinesItems.isNotEmpty)
          _SectionCardUI(title: 'VACCINES', edit: true, items: vaccinesItems),
        if (sawdustItems.isNotEmpty)
          _SectionCardUI(title: 'SAWDUST', edit: true, items: sawdustItems),
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
                  child: const Text(
                    'EDIT ITEMS',
                    style: TextStyle(
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
