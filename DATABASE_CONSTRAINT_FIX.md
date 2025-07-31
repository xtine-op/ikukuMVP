# Database Constraint Fix for Farm Reports

## Problem
The application is encountering a PostgreSQL constraint violation error:
```
PostgrestException(message: duplicate key value violates unique constraint "unique_user_date", code: 23505, details: Conflict, hint: null)
```

## Root Cause
The database has a constraint called "unique_user_date" that prevents multiple records for the same user on the same date. However, the application is designed to allow **one report per batch per day**, not one report per user per day.

## Solution

### Option 1: Manual Database Fix (Recommended)
Run this SQL command in your Supabase SQL editor:

```sql
-- Drop the existing constraint that prevents multiple reports per user per day
ALTER TABLE daily_records DROP CONSTRAINT IF EXISTS unique_user_date;

-- The application will handle the business logic of one report per batch per day
-- through the hasDailyRecordForBatch() function
```

### Option 2: Application-Level Fix
The application has been updated to:
1. Check for existing reports before saving
2. Handle constraint violation errors gracefully
3. Show user-friendly error messages

## Business Logic
- **One report per batch per day**: Farmers can submit one report per batch per day
- **Multiple batches per day**: Farmers can report on different batches on the same day
- **Data integrity**: The application checks for existing reports before saving

## Error Handling
The application now shows these user-friendly messages:
- "A report for this batch has already been submitted today. Please try again tomorrow."
- "This report has already been submitted. Please check your reports."

## Testing
After applying the fix:
1. Try submitting a report for a batch
2. Try submitting another report for the same batch on the same day (should be prevented)
3. Try submitting a report for a different batch on the same day (should work)

## Notes
- The constraint fix is applied automatically when the app starts
- If the manual SQL fix fails, the application will still work but may show technical error messages
- The business logic is enforced at the application level for better user experience 