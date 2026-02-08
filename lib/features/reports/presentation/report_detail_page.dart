import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportDetailPage extends StatelessWidget {
  final Map<String, dynamic> report;
  final Map<String, dynamic>? batch;
  const ReportDetailPage({super.key, required this.report, this.batch});

  void _editSection(BuildContext context, int stepIndex) {
    context.push(
      '/report-entry',
      extra: {'report': report, 'batch': batch, 'initialStep': stepIndex},
    );
  }

  @override
  Widget build(BuildContext context) {
    final batchData = batch ?? {};
    final birdType = (batchData['bird_type'] ?? '').toString().toLowerCase();
    final batchName = batchData['name'] ?? 'Unknown';
    final chickensSold = report['chickens_sold'] ?? 0;
    final chickensCurled = report['chickens_curled'] ?? 0;
    final chickensDied = report['chickens_died'] ?? 0;
    final chickensStolen = report['chickens_stolen'] ?? 0;
    final showEggs =
        birdType == 'kienyeji' || birdType == 'layer' || birdType == 'layers';
    final eggsCollected = report['eggs_collected'];
    final bigEggs = report['eggs_standard'] ?? 0;
    final deformedEggs = report['eggs_deformed'] ?? 0;
    final brokenEggs = report['eggs_broken'] ?? 0;
    final feedsUsed = (report['feeds_used'] is List)
        ? List<Map<String, dynamic>>.from(report['feeds_used'])
        : [];
    final vaccinesUsed = (report['vaccines_used'] is List)
        ? List<Map<String, dynamic>>.from(report['vaccines_used'])
        : [];
    final otherMaterialsUsed = (report['other_materials_used'] is List)
        ? List<Map<String, dynamic>>.from(report['other_materials_used'])
        : [];
    final notes = report['notes']?.toString() ?? '';
    final date =
        DateTime.tryParse(report['record_date'] ?? '') ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(title: Text('report_details'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF8E2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'farm_report'.tr(),
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
                        '${date.day}/${date.month}/${date.year}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.layers, size: 16, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(
                        '$batchName - ${birdType.isNotEmpty ? birdType : 'unknown_type'.tr()}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _SectionCard(
              title: '${'birds'.tr()}- ${birdType.toUpperCase()}',
              onEdit: () => _editSection(context, 2),
              items: [
                _SectionItem(
                  label: 'sold'.tr(),
                  value: chickensSold.toString(),
                ),
                _SectionItem(
                  label: 'died'.tr(),
                  value: chickensDied.toString(),
                ),
                _SectionItem(
                  label: 'curled'.tr(),
                  value: chickensCurled.toString(),
                ),
                _SectionItem(
                  label: 'stolen'.tr(),
                  value: chickensStolen.toString(),
                ),
              ],
            ),
            if (showEggs && eggsCollected != null)
              _SectionCard(
                title: 'eggs'.tr(),
                onEdit: () => _editSection(context, 3),
                items: [
                  _SectionItem(
                    label: 'collected'.tr(),
                    value: eggsCollected.toString(),
                  ),
                  _SectionItem(
                    label: 'broken'.tr(),
                    value: brokenEggs.toString(),
                  ),
                  _SectionItem(label: 'big'.tr(), value: bigEggs.toString()),
                  _SectionItem(
                    label: 'deformed'.tr(),
                    value: deformedEggs.toString(),
                  ),
                ],
              ),
            _SectionCard(
              title: 'feeds_used'.tr(),
              onEdit: () =>
                  _editSection(context, birdType == 'broiler' ? 3 : 4),
              items: [
                ...feedsUsed.map(
                  (f) => _SectionItem(
                    label: f['name'] ?? '',
                    value: f['quantity'] != null
                        ? '${f['quantity']} ${'kg'.tr()}'
                        : '',
                  ),
                ),
              ],
            ),
            _SectionCard(
              title: 'vaccines'.tr(),
              onEdit: () =>
                  _editSection(context, birdType == 'broiler' ? 4 : 5),
              items: vaccinesUsed.isNotEmpty
                  ? [
                      ...vaccinesUsed.map(
                        (v) => _SectionItem(
                          label: v['name'] ?? '',
                          value: v['quantity'] != null
                              ? '${v['quantity']} ${'lit'.tr()}'
                              : '',
                        ),
                      ),
                    ]
                  : [_SectionItem(label: '', value: 'no_items_used'.tr())],
            ),
            _SectionCard(
              title: 'other_materials'.tr(),
              onEdit: () =>
                  _editSection(context, birdType == 'broiler' ? 5 : 6),
              items: otherMaterialsUsed.isNotEmpty
                  ? [
                      ...otherMaterialsUsed.map(
                        (m) => _SectionItem(
                          label: m['name'] ?? '',
                          value: m['quantity'] != null
                              ? '${m['quantity']}kg'
                              : '',
                        ),
                      ),
                    ]
                  : [_SectionItem(label: '', value: 'no_items_used'.tr())],
            ),
            if (notes.isNotEmpty)
              _SectionCard(
                title: 'additional_notes'.tr(),
                onEdit: () =>
                    _editSection(context, birdType == 'broiler' ? 6 : 7),
                items: [_SectionItem(label: '', value: notes)],
              ),
            const SizedBox(height: 16),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: CustomColors.text,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ).copyWith(backgroundColor: WidgetStateProperty.all(null)),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: CustomColors.buttonGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(minHeight: 48),
                      child: Text(
                        'close_report'.tr(),
                        style: const TextStyle(color: CustomColors.text),
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
  final VoidCallback? onEdit;
  final List<_SectionItem> items;
  const _SectionCard({required this.title, this.onEdit, required this.items});

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
              if (onEdit != null)
                GestureDetector(
                  onTap: onEdit,
                  child: Text(
                    'EDIT ITEMS',
                    style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.w600,
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
                      color: CustomColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    softWrap: true,
                    maxLines: null,
                    overflow: TextOverflow.visible,
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
