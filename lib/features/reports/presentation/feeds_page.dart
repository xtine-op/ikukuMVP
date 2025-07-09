import 'package:flutter/material.dart';
import '../../inventory/data/inventory_item_model.dart';

class FeedsPage extends StatelessWidget {
  final List<InventoryItem> feeds;
  final InventoryItem? selectedFeed;
  final ValueChanged<InventoryItem?> onFeedSelected;
  final double? feedAmount;
  final ValueChanged<String> onFeedAmountChanged;
  final VoidCallback onContinue;

  const FeedsPage({
    super.key,
    required this.feeds,
    required this.selectedFeed,
    required this.onFeedSelected,
    required this.feedAmount,
    required this.onFeedAmountChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select the feed type you used today.'),
          DropdownButton<InventoryItem>(
            value: selectedFeed,
            hint: const Text('Select feed'),
            items: feeds
                .map(
                  (feed) => DropdownMenuItem(
                    value: feed,
                    child: Text('${feed.name} (Stock: ${feed.quantity})'),
                  ),
                )
                .toList(),
            onChanged: onFeedSelected,
          ),
          if (selectedFeed != null) ...[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount used today (Kg)',
              ),
              keyboardType: TextInputType.number,
              onChanged: onFeedAmountChanged,
            ),
            if (feedAmount != null &&
                feedAmount! > (selectedFeed?.quantity ?? 0))
              const Text(
                'Cannot use more feed than available in store.',
                style: TextStyle(color: Colors.red),
              ),
          ],
          const Spacer(),
          ElevatedButton(
            onPressed: selectedFeed != null ? onContinue : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
