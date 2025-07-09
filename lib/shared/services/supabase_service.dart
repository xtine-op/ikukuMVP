import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final supabase = Supabase.instance.client;

  // Example: Fetch all batches for a user
  Future<List<Map<String, dynamic>>> fetchBatches(String userId) async {
    final response = await supabase
        .from('batches')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Example: Add a new batch
  Future<void> addBatch(Map<String, dynamic> batch) async {
    await supabase.from('batches').insert(batch);
  }

  // Update an existing batch
  Future<void> updateBatch(Map<String, dynamic> batch) async {
    await supabase.from('batches').update(batch).eq('id', batch['id']);
  }

  // Delete a batch by id
  Future<void> deleteBatch(String id) async {
    await supabase.from('batches').delete().eq('id', id);
  }

  // Fetch all inventory items for a user
  Future<List<Map<String, dynamic>>> fetchInventory(String userId) async {
    final response = await supabase
        .from('inventory_items')
        .select()
        .eq('user_id', userId)
        .order('added_on', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Add a new inventory item
  Future<void> addInventoryItem(Map<String, dynamic> item) async {
    await supabase.from('inventory_items').insert(item);
  }

  // Update an inventory item
  Future<void> updateInventoryItem(Map<String, dynamic> item) async {
    await supabase.from('inventory_items').update(item).eq('id', item['id']);
  }

  // Delete an inventory item by id
  Future<void> deleteInventoryItem(String id) async {
    await supabase.from('inventory_items').delete().eq('id', id);
  }

  // Fetch all daily records for a user
  Future<List<Map<String, dynamic>>> fetchDailyRecords(String userId) async {
    final response = await supabase
        .from('daily_records')
        .select()
        .eq('user_id', userId)
        .order('record_date', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Add a new daily record
  Future<String> addDailyRecord(Map<String, dynamic> record) async {
    final response = await supabase
        .from('daily_records')
        .insert(record)
        .select()
        .single();
    return response['id'] as String;
  }

  // Fetch aggregated reports for a user (example: monthly summary)
  Future<List<Map<String, dynamic>>> fetchReports(String userId) async {
    // This is a placeholder. In a real app, you might use a Supabase function or view for aggregation.
    final response = await supabase.rpc(
      'get_monthly_farm_summary',
      params: {'user_id': userId},
    );
    return List<Map<String, dynamic>>.from(response);
  }

  // Add a new batch record
  Future<void> addBatchRecord(Map<String, dynamic> record) async {
    await supabase.from('batch_records').insert(record);
  }

  // Add similar methods for records, etc.
}
