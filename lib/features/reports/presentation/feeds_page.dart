import 'package:flutter/material.dart';
import '../../inventory/data/inventory_item_model.dart';
import '../../../app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

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
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _selectedFeeds = List<Map<String, dynamic>>.from(widget.selectedFeeds);
    _initializeControllers();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    for (final feed in _selectedFeeds) {
      final name = feed['name'] as String;
      if (!_controllers.containsKey(name)) {
        _controllers[name] = TextEditingController(
          text: feed['quantity']?.toString() ?? '',
        );
      }
    }
  }

  void _toggleFeed(InventoryItem feed, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedFeeds.any((f) => f['name'] == feed.name)) {
          _selectedFeeds.add({'name': feed.name, 'quantity': null});
          _controllers[feed.name] = TextEditingController();
        }
      } else {
        _selectedFeeds.removeWhere((f) => f['name'] == feed.name);
        _controllers[feed.name]?.dispose();
        _controllers.remove(feed.name);
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
                  'cannot_use_more_than'.tr(
                    namedArgs: {
                      'quantity': feed.quantity.toString(),
                      'unit': 'kg'.tr(),
                      'item': feed.name,
                    },
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
            // Reset the controller to the previous valid value
            _controllers[feedName]?.text =
                _selectedFeeds[idx]['quantity']?.toString() ?? '';
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
        Text(
          'select_feed_types_today'.tr(),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        ...widget.feeds.map((feed) {
          final isSelected = _selectedFeeds.any((f) => f['name'] == feed.name);
          return CheckboxListTile(
            value: isSelected,
            title: Text(
              '${feed.name.tr()} (${"stock".tr()}: ${feed.quantity} ${"kg".tr()})',
            ),
            onChanged: (checked) => _toggleFeed(feed, checked ?? false),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),
        const SizedBox(height: 16),
        ..._selectedFeeds.map((f) {
          final feedName = f['name'] as String;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feedName.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _controllers[feedName],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  hintText: 'enter_quantity_kg'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixText: 'kg'.tr(),
                ),
                onChanged: (v) => _updateQuantity(feedName, v),
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
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
                child: Text(
                  'continue'.tr(),
                  style: const TextStyle(color: CustomColors.text),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
