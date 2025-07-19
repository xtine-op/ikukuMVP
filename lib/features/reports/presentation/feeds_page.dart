import 'package:flutter/material.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';

class FeedsPage extends StatelessWidget {
  final List<InventoryItem> feeds;
  final List<Map<String, dynamic>> selectedFeeds;
  final void Function(List<Map<String, dynamic>>) onSelectedFeedsChanged;
  final VoidCallback onContinue;

  const FeedsPage({
    super.key,
    required this.feeds,
    required this.selectedFeeds,
    required this.onSelectedFeedsChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: _FeedsSelector(
          feeds: feeds,
          selectedFeeds: selectedFeeds,
          onSelectedFeedsChanged: onSelectedFeedsChanged,
          onContinue: onContinue,
        ),
      ),
    );
  }
}

class _FeedsSelector extends StatefulWidget {
  final List<InventoryItem> feeds;
  final List<Map<String, dynamic>> selectedFeeds;
  final void Function(List<Map<String, dynamic>>) onSelectedFeedsChanged;
  final VoidCallback onContinue;

  const _FeedsSelector({
    required this.feeds,
    required this.selectedFeeds,
    required this.onSelectedFeedsChanged,
    required this.onContinue,
  });

  @override
  State<_FeedsSelector> createState() => _FeedsSelectorState();
}

class _FeedsSelectorState extends State<_FeedsSelector> {
  late List<Map<String, dynamic>> _selectedFeeds;

  @override
  void initState() {
    super.initState();
    _selectedFeeds = List<Map<String, dynamic>>.from(widget.selectedFeeds);
  }

  void _toggleFeed(InventoryItem feed, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedFeeds.any((f) => f['name'] == feed.name)) {
          _selectedFeeds.add({'name': feed.name, 'quantity': null});
        }
      } else {
        _selectedFeeds.removeWhere((f) => f['name'] == feed.name);
      }
      widget.onSelectedFeedsChanged(_selectedFeeds);
    });
  }

  void _updateQuantity(String feedName, String value) {
    setState(() {
      final idx = _selectedFeeds.indexWhere((f) => f['name'] == feedName);
      if (idx != -1) {
        final quantity = double.tryParse(value);
        if (quantity != null && quantity >= 0) {
          // Find the feed to check available stock
          final feed = widget.feeds.firstWhere((f) => f.name == feedName);
          if (quantity <= feed.quantity) {
            _selectedFeeds[idx]['quantity'] = quantity;
          } else {
            // Show error for exceeding stock
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Cannot use more than ${feed.quantity} kg of ${feed.name}',
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        } else {
          _selectedFeeds[idx]['quantity'] = null;
        }
        widget.onSelectedFeedsChanged(_selectedFeeds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the feed types you used today.',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        ...widget.feeds.map((feed) {
          final isSelected = _selectedFeeds.any((f) => f['name'] == feed.name);
          return CheckboxListTile(
            value: isSelected,
            title: Text('${feed.name} (Stock: ${feed.quantity})'),
            onChanged: (checked) => _toggleFeed(feed, checked ?? false),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }).toList(),
        const SizedBox(height: 16),
        ..._selectedFeeds.map((f) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(f['name'], style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'Qty (Kg)',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: false,
                ),
                onChanged: (v) => _updateQuantity(f['name'], v),
                controller: TextEditingController(
                  text: f['quantity']?.toString() ?? '',
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: CustomColors.text,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: CustomColors.buttonGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minHeight: 48),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(color: CustomColors.text),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
