# StatusFeedback Widget Integration Guide

## Overview
The `StatusFeedback` widget has been successfully integrated into the ikuku MVP app for consistent, user-friendly error and success feedback across key workflows.

## Widget Components

### 1. **StatusFeedback Widget** (`lib/shared/widgets/status_feedback_widget.dart`)
A reusable Material 3 widget with:
- **Vertical Layout**: Heading → Image → Body Text → Action Button
- **Dynamic Theming**: Success (green) or Error (red) based on `StatusType` enum
- **Flexible**: Accepts any image path (SVG or PNG)
- **App Theme Integration**: Uses `CustomColors` for consistent branding

#### Key Features:
- Heading: Large, bold text (headlineLarge)
- Image: 150px centered image (SVG or PNG)
- Body Text: One-line description (bodyLarge)
- Button: Full-width 48px ElevatedButton
- Padding: Consistent 24px horizontal, 40px vertical margins
- Button Colors:
  - Success: `#00A152` (green)
  - Error: `#E53935` (red)

### 2. **Status Feedback Screens** (`lib/shared/screens/status_feedback_screens.dart`)
Three pre-configured screen components:

#### StoreSuccessScreen
- **Heading**: "Stock Updated"
- **Body**: "Your inventory has been successfully updated."
- **Button**: "View Store" (navigates back or executes custom callback)
- **Use Case**: After adding/updating inventory items

#### StoreErrorScreen
- **Heading**: "Update Failed"
- **Body**: "We couldn't save that item. Please try again."
- **Button**: "Try Again" (triggers retry action)
- **Use Case**: When inventory update fails

#### ReportErrorScreen
- **Heading**: "Save Failed"
- **Body**: "Your report wasn't saved. Check your connection."
- **Button**: "Try Again" (triggers retry action)
- **Use Case**: When report submission fails

---

## Integration Points

### 1. **Farm Report Entry Page** (`lib/features/reports/presentation/farm_report_entry_page.dart`)

**Location**: Report save error handling

**Changes**:
- Added imports for `StatusFeedback` and `ReportErrorScreen`
- Replaced AlertDialog error with full-screen `ReportErrorScreen`
- Shows when:
  - Network error during report submission
  - Duplicate report constraint violation
  - Any save failure

**Flow**:
```
_saveReport()
  ├─ Try online/offline save
  └─ Catch error
     └─ Push ReportErrorScreen
        ├─ User taps "Try Again"
        └─ Pop screen and allow retry
```

**Before**: 
```dart
showDialog(
  context: context,
  builder: (ctx) => AlertDialog(...),
);
```

**After**:
```dart
await Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => ReportErrorScreen(
      onTryAgain: () {
        Navigator.of(context).pop();
        _showingDialog = false;
      },
    ),
  ),
);
```

---

### 2. **Inventory Page** (`lib/features/inventory/presentation/inventory_page.dart`)

**Location**: Add/Update inventory items

**Changes**:
- Added imports for `StatusFeedback`, `StoreSuccessScreen`, and `StoreErrorScreen`
- Wrapped add/update item logic in try-catch
- Shows `StoreSuccessScreen` on success
- Shows `StoreErrorScreen` on failure

**Add Item Flow**:
```
_showAddItemDialog()
  ├─ Try
  │  ├─ addInventoryItem()
  │  ├─ Update dashboard
  │  └─ Push StoreSuccessScreen
  │     ├─ User taps "View Store"
  │     └─ Pop & refresh items
  └─ Catch error
     └─ Push StoreErrorScreen
        ├─ User taps "Try Again"
        └─ Pop & reopen dialog
```

**Edit Item Flow**:
Same as add, with quantity delta calculation for feeds

**Before**:
```dart
Navigator.pop(context);
fetchItems();
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Updated!'),),
);
```

**After**:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => StoreSuccessScreen(
      onViewStore: () {
        Navigator.pop(context);
        fetchItems();
      },
    ),
  ),
);
```

---

## Theme Integration

### Color Additions (`lib/app_theme.dart`)
Added to `CustomColors` class:
```dart
static const Color successColor = Color(0xFF00A152);  // Green
static const Color errorColor = Color(0xFFE53935);    // Red
static const Color textColorSecondary = Color(0xFF666666); // Secondary text
```

### Text Styles
- **Heading**: `Theme.textTheme.headlineLarge` (bold)
- **Body**: `Theme.textTheme.bodyLarge`
- **Button**: `Theme.textTheme.labelLarge` (bold)

All styled with app-specific colors and Google Fonts (DM Sans)

---

## Asset Requirements

For full functionality, the following SVG images should be added to `assets/icons/`:

1. **success_checkmark.svg** - Green checkmark for success states
2. **error_warning.svg** - Red warning icon for error states

**Current Behavior**: App will run without these assets; images will show as placeholders.

---

## Usage Examples

### Using StatusFeedback Directly
```dart
StatusFeedback(
  heading: 'Custom Success',
  bodyText: 'Operation completed successfully.',
  buttonLabel: 'Continue',
  statusType: StatusType.success,
  imagePath: 'assets/icons/success_checkmark.svg',
  onButtonPressed: () {
    Navigator.pop(context);
  },
)
```

### Using Pre-configured Screens
```dart
// Success
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => StoreSuccessScreen(
      onViewStore: () => Navigator.pop(context),
    ),
  ),
);

// Error
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => StoreErrorScreen(
      onTryAgain: () {
        Navigator.pop(context);
        // Trigger retry logic
      },
    ),
  ),
);
```

---

## Testing Checklist

- [ ] Add new inventory item → See success screen
- [ ] Update inventory item → See success screen
- [ ] Fail to add item (e.g., network error) → See error screen
- [ ] Tap "Try Again" on error → Retry works
- [ ] Submit farm report successfully (online mode)
- [ ] Fail to submit report → See error screen
- [ ] Tap "Try Again" on error → Can retry submission
- [ ] Button colors match theme (green/red)
- [ ] Text is readable and properly centered
- [ ] Images load correctly (or show placeholders)
- [ ] Navigation works in both directions

---

## Future Enhancements

1. **Add SVG icons** for success/error states
2. **Create Report Success Screen** for successful submissions
3. **Customize button text** per workflow
4. **Add animation** (scale-in, slide-up) for widget appearance
5. **Support for action buttons** (e.g., "Try Again" vs "Continue")
6. **Dark mode support** for status colors
7. **Localization keys** for success/error messages

---

## Files Modified

1. **`lib/shared/widgets/status_feedback_widget.dart`** - Widget definition
2. **`lib/shared/screens/status_feedback_screens.dart`** - Pre-configured screens
3. **`lib/app_theme.dart`** - Added color definitions
4. **`lib/features/reports/presentation/farm_report_entry_page.dart`** - Integrated error screen
5. **`lib/features/inventory/presentation/inventory_page.dart`** - Integrated success/error screens

---

## Support

For issues or feature requests related to StatusFeedback:
1. Check theme colors in `CustomColors`
2. Verify image paths are correct
3. Ensure callbacks are properly wired
4. Check localization keys if using translated text
