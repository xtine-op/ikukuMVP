import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app_theme.dart';

class SelectDatePage extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onContinue;
  final List<DateTime> reportedDates;

  const SelectDatePage({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
    required this.onContinue,
    this.reportedDates = const [],
  });

  @override
  State<SelectDatePage> createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize with selected date or today's date
    _selectedDate = widget.selectedDate ?? DateTime.now();
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? today,
      firstDate: DateTime.now().subtract(
        const Duration(days: 365),
      ), // 1 year ago
      lastDate: today,
      selectableDayPredicate: (DateTime date) {
        // Disable future dates
        if (date.isAfter(today)) {
          return false;
        }

        // Disable dates that already have reports for this batch
        return !widget.reportedDates.any(
          (d) =>
              d.year == date.year && d.month == date.month && d.day == date.day,
        );
      },
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: CustomColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: CustomColors.text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Report Date',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Text(
            'Choose the date for your farm report',
            style: TextStyle(fontSize: 16, color: CustomColors.textDisabled),
          ),
          const SizedBox(height: 24),

          // Date picker input field
          Text(
            'Report Date',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomColors.text,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select report date',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today, color: CustomColors.primary),
                onPressed: _selectDate,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: CustomColors.primary, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onTap: _selectDate,
          ),

          const Spacer(),

          // Continue button
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: CustomColors.buttonGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _selectedDate != null ? widget.onContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(200, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: CustomColors.text,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  child: Text(
                    'continue'.tr(),
                    style: const TextStyle(color: CustomColors.text),
                  ),
                ),
              ),
            ),
          ),

          if (_selectedDate == null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  'Please select a date to continue',
                  style: TextStyle(color: CustomColors.textDisabled),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
