import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../batches/data/batch_model.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';

class ReviewAndSavePage extends StatelessWidget {
  final Batch? selectedBatch;
  final String? chickenReduction;
  final Map<String, int> reductionCounts;
  final bool? collectedEggs;
  final int? eggsCollected;
  final bool? gradeEggs;
  final int? bigEggs;
  final int? deformedEggs;
  final int? brokenEggs;
  final InventoryItem? selectedFeed;
  final double? feedAmount;
  final InventoryItem? selectedVaccine;
  final double? vaccineAmount;
  final Map<InventoryItem, double> otherMaterialsUsed;
  final String? notes;
  final VoidCallback onSave;
  final List<Map<String, dynamic>> selectedFeeds;
  final List<Map<String, dynamic>> selectedVaccines;
  final List<Map<String, dynamic>> selectedOtherMaterials;

  const ReviewAndSavePage({
    super.key,
    required this.selectedBatch,
    required this.chickenReduction,
    required this.reductionCounts,
    required this.collectedEggs,
    required this.eggsCollected,
    required this.gradeEggs,
    required this.bigEggs,
    required this.deformedEggs,
    required this.brokenEggs,
    required this.selectedFeed,
    required this.feedAmount,
    required this.selectedVaccine,
    required this.vaccineAmount,
    required this.otherMaterialsUsed,
    required this.notes,
    required this.onSave,
    required this.selectedFeeds,
    required this.selectedVaccines,
    required this.selectedOtherMaterials,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final isBroiler =
        (selectedBatch?.birdType.toLowerCase() ?? '') == 'broiler';
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: CustomColors.primary),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const Spacer(),
              Text(
                'confirm'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
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
                  style: const TextStyle(
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
                      '${date.day} ${_monthName(date.month)} ${date.year}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.layers, size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      '${selectedBatch?.name ?? ''} - ${selectedBatch?.birdType ?? ''}',
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
                'birds'.tr() +
                '- ' +
                (selectedBatch?.birdType.toUpperCase() ?? ''),
            onEdit: () {},
            items: [
              _SectionItem(label: 'sold'.tr(), value: '0'),
              _SectionItem(
                label: 'died'.tr(),
                value: (reductionCounts['death'] ?? 0).toString(),
              ),
              _SectionItem(
                label: 'curled'.tr(),
                value: (reductionCounts['curled'] ?? 0).toString(),
              ),
              _SectionItem(
                label: 'stolen'.tr(),
                value: (reductionCounts['stolen'] ?? 0).toString(),
              ),
            ],
          ),
          // Eggs Section (exclude if broiler)
          if (!isBroiler)
            _SectionCard(
              title: 'eggs'.tr(),
              onEdit: () {},
              items: [
                _SectionItem(
                  label: 'collected'.tr(),
                  value: (eggsCollected ?? 0).toString(),
                ),
                _SectionItem(
                  label: 'broken'.tr(),
                  value: (brokenEggs ?? 0).toString(),
                ),
                _SectionItem(
                  label: 'big'.tr(),
                  value: (bigEggs ?? 0).toString(),
                ),
                _SectionItem(
                  label: 'deformed'.tr(),
                  value: (deformedEggs ?? 0).toString(),
                ),
              ],
            ),
          // Feeds Section (show all selected feeds)
          _SectionCard(
            title: 'feeds_used'.tr(),
            onEdit: () {},
            items: [
              ...selectedFeeds.map(
                (f) => _SectionItem(
                  label: f['name'] ?? '',
                  value: f['quantity'] != null ? '${f['quantity']} Kg' : '',
                ),
              ),
            ],
          ),
          // Vaccines Section (show all selected vaccines)
          _SectionCard(
            title: 'vaccines'.tr(),
            onEdit: () {},
            items: [
              ...selectedVaccines.map(
                (v) => _SectionItem(
                  label: v['name'] ?? '',
                  value: v['quantity'] != null ? '${v['quantity']} Lit' : '',
                ),
              ),
            ],
          ),
          // Other Materials Section (show all selected other materials)
          _SectionCard(
            title: 'other_materials'.tr(),
            onEdit: () {},
            items: [
              ...selectedOtherMaterials.map(
                (m) => _SectionItem(
                  label: m['name'] ?? '',
                  value: m['quantity'] != null ? '${m['quantity']}kg' : '',
                ),
              ),
            ],
          ),
          // Additional Notes Section
          if (notes != null && notes!.trim().isNotEmpty)
            _SectionCard(
              title: 'additional_notes'.tr(),
              onEdit: () {},
              items: [_SectionItem(label: '', value: notes!)],
            ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'this_report_prepared_on'.tr() +
                  '\n' +
                  ' ${date.day}/${date.month}/${date.year} ' +
                  'at ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.black54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSave,
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
                    'finish_reporting'.tr(),
                    style: const TextStyle(color: CustomColors.text),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _monthName(int month) {
  const months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month];
}

class _SectionCard extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  final List<_SectionItem> items;
  const _SectionCard({
    required this.title,
    required this.onEdit,
    required this.items,
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
