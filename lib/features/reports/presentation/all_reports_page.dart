import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../shared/services/supabase_service.dart';
import '../../../app_theme.dart';
import '../../batches/data/batch_model.dart';
import 'report_detail_page.dart';

class AllReportsPage extends StatefulWidget {
  const AllReportsPage({super.key});

  @override
  State<AllReportsPage> createState() => _AllReportsPageState();
}

class _AllReportsPageState extends State<AllReportsPage> {
  List<Map<String, dynamic>> allReports = [];
  List<Map<String, dynamic>> filteredReports = [];
  List<Batch> batches = [];
  bool loading = true;

  // Search and filter controllers
  final TextEditingController _searchController = TextEditingController();
  String? selectedBatchName;
  String? selectedBatchType;
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    _fetchAllReports();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  Future<void> _fetchAllReports() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        setState(() => loading = false);
        return;
      }

      // Fetch batches for filtering
      final fetchedBatches = await SupabaseService().fetchBatches(user.id);
      batches = fetchedBatches.map((b) => Batch.fromJson(b)).toList();

      // Fetch all daily records
      final dailyRecords = await SupabaseService().fetchDailyRecords(user.id);

      // Fetch all batch records with their associated data
      List<Map<String, dynamic>> reports = [];
      for (final dailyRecord in dailyRecords) {
        final batchRecords = await SupabaseService()
            .fetchBatchRecordsForDailyRecord(dailyRecord['id']);

        for (final batchRecord in batchRecords) {
          // Find the associated batch
          final batch = batches.firstWhere(
            (b) => b.id == batchRecord['batch_id'],
            orElse: () => Batch.empty(''),
          );

          // Combine all data into a single report object
          final report = {
            ...batchRecord,
            'record_date': dailyRecord['record_date'],
            'daily_record_id': dailyRecord['id'],
            'batch_name': batch.name,
            'batch_type': batch.birdType,
            'batch_age': batch.currentAgeInDays,
            'batch_total_chickens': batch.totalChickens,
          };
          reports.add(report);
        }
      }

      // Sort reports by date (newest first)
      reports.sort((a, b) {
        final dateA =
            DateTime.tryParse(a['record_date'] ?? '') ?? DateTime.now();
        final dateB =
            DateTime.tryParse(b['record_date'] ?? '') ?? DateTime.now();
        return dateB.compareTo(dateA);
      });

      setState(() {
        allReports = reports;
        filteredReports = reports;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading reports: $e')));
      }
    }
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(allReports);

    // Apply search filter
    final searchQuery = _searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((report) {
        final batchName = (report['batch_name'] ?? '').toString().toLowerCase();
        final batchType = (report['batch_type'] ?? '').toString().toLowerCase();
        final notes = (report['notes'] ?? '').toString().toLowerCase();

        return batchName.contains(searchQuery) ||
            batchType.contains(searchQuery) ||
            notes.contains(searchQuery);
      }).toList();
    }

    // Apply batch name filter
    if (selectedBatchName != null && selectedBatchName!.isNotEmpty) {
      filtered = filtered
          .where((report) => report['batch_name'] == selectedBatchName)
          .toList();
    }

    // Apply batch type filter
    if (selectedBatchType != null && selectedBatchType!.isNotEmpty) {
      filtered = filtered
          .where((report) => report['batch_type'] == selectedBatchType)
          .toList();
    }

    // Apply date range filter
    if (selectedDateRange != null) {
      filtered = filtered.where((report) {
        final reportDate = DateTime.tryParse(report['record_date'] ?? '');
        if (reportDate == null) return false;

        return reportDate.isAfter(
              selectedDateRange!.start.subtract(const Duration(days: 1)),
            ) &&
            reportDate.isBefore(
              selectedDateRange!.end.add(const Duration(days: 1)),
            );
      }).toList();
    }

    setState(() {
      filteredReports = filtered;
    });
  }

  void _clearFilters() {
    setState(() {
      selectedBatchName = null;
      selectedBatchType = null;
      selectedDateRange = null;
      _searchController.clear();
      filteredReports = allReports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('all_reports'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/reports'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildSearchBar(),
                _buildFilterChips(),
                Expanded(child: _buildReportsList()),
              ],
            ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'search_reports'.tr(),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final hasFilters =
        selectedBatchName != null ||
        selectedBatchType != null ||
        selectedDateRange != null;

    if (!hasFilters) return const SizedBox.shrink();

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (selectedBatchName != null)
            _buildFilterChip(
              '${'batch_name'.tr()}: $selectedBatchName',
              () => setState(() {
                selectedBatchName = null;
                _applyFilters();
              }),
            ),
          if (selectedBatchType != null)
            _buildFilterChip(
              '${'batch_type'.tr()}: $selectedBatchType',
              () => setState(() {
                selectedBatchType = null;
                _applyFilters();
              }),
            ),
          if (selectedDateRange != null)
            _buildFilterChip(
              '${'date_range'.tr()}: ${DateFormat('MMM dd').format(selectedDateRange!.start)} - ${DateFormat('MMM dd').format(selectedDateRange!.end)}',
              () => setState(() {
                selectedDateRange = null;
                _applyFilters();
              }),
            ),
          const SizedBox(width: 8),
          TextButton(onPressed: _clearFilters, child: Text('clear_all'.tr())),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        onDeleted: onRemove,
        backgroundColor: CustomColors.lightYellow,
      ),
    );
  }

  Widget _buildReportsList() {
    if (filteredReports.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              allReports.isEmpty
                  ? 'no_reports_yet'.tr()
                  : 'no_reports_match_filter'.tr(),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // Group reports by date
    final groupedReports = <String, List<Map<String, dynamic>>>{};
    for (final report in filteredReports) {
      final date =
          DateTime.tryParse(report['record_date'] ?? '') ?? DateTime.now();
      final dateKey = DateFormat('yyyy-MM-dd').format(date);

      if (!groupedReports.containsKey(dateKey)) {
        groupedReports[dateKey] = [];
      }
      groupedReports[dateKey]!.add(report);
    }

    // Sort dates in descending order (newest first)
    final sortedDates = groupedReports.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final dateKey = sortedDates[index];
        final reportsForDate = groupedReports[dateKey]!;
        final date = DateTime.parse(dateKey);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 12,
                top: index == 0 ? 0 : 24,
              ),
              child: Text(
                DateFormat('EEEE, MMMM dd, yyyy').format(date),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            // Reports for this date
            ...reportsForDate.map((report) => _buildReportCard(report)),
          ],
        );
      },
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    final batchName = report['batch_name'] ?? 'unknown_batch'.tr();
    final batchType = report['batch_type'] ?? 'unknown_type'.tr();

    // Calculate summary stats
    final totalReductions =
        (report['chickens_sold'] ?? 0) +
        (report['chickens_died'] ?? 0) +
        (report['chickens_curled'] ?? 0) +
        (report['chickens_stolen'] ?? 0);
    final eggsCollected = report['eggs_collected'] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          batchName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              batchType.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (totalReductions > 0) ...[
                  Icon(Icons.trending_down, size: 16, color: Colors.red[600]),
                  const SizedBox(width: 4),
                  Text(
                    '$totalReductions ${'reductions'.tr()}',
                    style: TextStyle(fontSize: 12, color: Colors.red[600]),
                  ),
                  const SizedBox(width: 16),
                ],
                if (eggsCollected > 0) ...[
                  Icon(Icons.egg_outlined, size: 16, color: Colors.orange[600]),
                  const SizedBox(width: 4),
                  Text(
                    '$eggsCollected ${'eggs'.tr()}',
                    style: TextStyle(fontSize: 12, color: Colors.orange[600]),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black),
        onTap: () => _openReportDetail(report),
      ),
    );
  }

  void _openReportDetail(Map<String, dynamic> report) {
    // Find the batch data for the report
    final batch = batches.firstWhere(
      (b) => b.id == report['batch_id'],
      orElse: () => Batch.empty(''),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ReportDetailPage(report: report, batch: batch.toJson()),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheet(
        batches: batches,
        selectedBatchName: selectedBatchName,
        selectedBatchType: selectedBatchType,
        selectedDateRange: selectedDateRange,
        onFiltersChanged: (batchName, batchType, dateRange) {
          setState(() {
            selectedBatchName = batchName;
            selectedBatchType = batchType;
            selectedDateRange = dateRange;
          });
          _applyFilters();
        },
      ),
    );
  }
}

class _FilterBottomSheet extends StatefulWidget {
  final List<Batch> batches;
  final String? selectedBatchName;
  final String? selectedBatchType;
  final DateTimeRange? selectedDateRange;
  final Function(String?, String?, DateTimeRange?) onFiltersChanged;

  const _FilterBottomSheet({
    required this.batches,
    required this.selectedBatchName,
    required this.selectedBatchType,
    required this.selectedDateRange,
    required this.onFiltersChanged,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  String? _selectedBatchName;
  String? _selectedBatchType;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedBatchName = widget.selectedBatchName;
    _selectedBatchType = widget.selectedBatchType;
    _selectedDateRange = widget.selectedDateRange;
  }

  @override
  Widget build(BuildContext context) {
    final uniqueBatchNames = widget.batches.map((b) => b.name).toSet().toList();
    final uniqueBatchTypes = widget.batches
        .map((b) => b.birdType)
        .toSet()
        .toList();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'filter_reports'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedBatchName = null;
                    _selectedBatchType = null;
                    _selectedDateRange = null;
                  });
                },
                child: Text('clear_all'.tr()),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Batch Name Filter
          Text(
            'batch_name'.tr(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedBatchName,
            decoration: InputDecoration(
              hintText: 'select_batch_name'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            items: [
              DropdownMenuItem<String>(
                value: null,
                child: Text('all_batches'.tr()),
              ),
              ...uniqueBatchNames.map(
                (name) =>
                    DropdownMenuItem<String>(value: name, child: Text(name)),
              ),
            ],
            onChanged: (value) => setState(() => _selectedBatchName = value),
          ),
          const SizedBox(height: 16),

          // Batch Type Filter
          Text(
            'batch_type'.tr(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedBatchType,
            decoration: InputDecoration(
              hintText: 'select_batch_type'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            items: [
              DropdownMenuItem<String>(
                value: null,
                child: Text('all_types'.tr()),
              ),
              ...uniqueBatchTypes.map(
                (type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type.toUpperCase()),
                ),
              ),
            ],
            onChanged: (value) => setState(() => _selectedBatchType = value),
          ),
          const SizedBox(height: 16),

          // Date Range Filter
          Text(
            'date_range'.tr(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _selectDateRange,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDateRange == null
                        ? 'select_date_range'.tr()
                        : '${DateFormat('MMM dd, yyyy').format(_selectedDateRange!.start)} - ${DateFormat('MMM dd, yyyy').format(_selectedDateRange!.end)}',
                    style: TextStyle(
                      color: _selectedDateRange == null
                          ? Colors.grey[600]
                          : Colors.black,
                    ),
                  ),
                  const Icon(Icons.calendar_today, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onFiltersChanged(
                  _selectedBatchName,
                  _selectedBatchType,
                  _selectedDateRange,
                );
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'apply_filters'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: CustomColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }
}
