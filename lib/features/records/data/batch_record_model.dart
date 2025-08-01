import 'package:uuid/uuid.dart';
import 'dart:convert';

class FeedUsage {
  final String name;
  final double quantity;
  FeedUsage({required this.name, required this.quantity});

  factory FeedUsage.fromJson(Map<String, dynamic> json) {
    try {
      print('FeedUsage.fromJson - Raw json: $json');
      final name = json['name']?.toString() ?? '';
      final quantity = (json['quantity'] as num?)?.toDouble() ?? 0.0;
      print('FeedUsage.fromJson - Parsed: name=$name, quantity=$quantity');
      return FeedUsage(name: name, quantity: quantity);
    } catch (e) {
      print('Error parsing FeedUsage: $e, json: $json');
      return FeedUsage(name: '', quantity: 0.0);
    }
  }

  Map<String, dynamic> toJson() => {'name': name, 'quantity': quantity};
}

class VaccineUsage {
  final String name;
  final double quantity;
  VaccineUsage({required this.name, required this.quantity});

  factory VaccineUsage.fromJson(Map<String, dynamic> json) {
    try {
      print('VaccineUsage.fromJson - Raw json: $json');
      final name = json['name']?.toString() ?? '';
      final quantity = (json['quantity'] as num?)?.toDouble() ?? 0.0;
      print('VaccineUsage.fromJson - Parsed: name=$name, quantity=$quantity');
      return VaccineUsage(name: name, quantity: quantity);
    } catch (e) {
      print('Error parsing VaccineUsage: $e, json: $json');
      return VaccineUsage(name: '', quantity: 0.0);
    }
  }

  Map<String, dynamic> toJson() => {'name': name, 'quantity': quantity};
}

class OtherMaterialUsage {
  final String name;
  final double quantity;
  final String? unit;
  OtherMaterialUsage({required this.name, required this.quantity, this.unit});

  factory OtherMaterialUsage.fromJson(Map<String, dynamic> json) {
    try {
      return OtherMaterialUsage(
        name: json['name']?.toString() ?? '',
        quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
        unit: json['unit']?.toString(),
      );
    } catch (e) {
      print('Error parsing OtherMaterialUsage: $e, json: $json');
      return OtherMaterialUsage(name: '', quantity: 0.0);
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    if (unit != null) 'unit': unit,
  };
}

class BatchRecord {
  final String id;
  final String dailyRecordId;
  final String batchId;
  final bool chickenReduction;
  final int chickensSold;
  final int chickensCurled;
  final int chickensDied;
  final int chickensStolen;
  final int? eggsCollected;
  final bool gradeEggs;
  final int? eggsSmall;
  final int? eggsDeformed;
  final int? eggsStandard;
  final double? feedUsedKg;
  final String? vaccinesGiven;
  final String? notes;
  final List<FeedUsage> feedsUsed;
  final List<VaccineUsage> vaccinesUsed;
  final List<OtherMaterialUsage> otherMaterialsUsed;
  final int? eggsBroken;
  final int? sawdustInStore;
  final int? sawdustUsed;
  final int? sawdustRemaining;

  BatchRecord({
    required this.id,
    required this.dailyRecordId,
    required this.batchId,
    required this.chickenReduction,
    required this.chickensSold,
    required this.chickensCurled,
    required this.chickensDied,
    required this.chickensStolen,
    this.eggsCollected,
    required this.gradeEggs,
    this.eggsSmall,
    this.eggsDeformed,
    this.eggsStandard,
    this.feedUsedKg,
    this.vaccinesGiven,
    this.notes,
    required this.feedsUsed,
    required this.vaccinesUsed,
    required this.otherMaterialsUsed,
    this.eggsBroken,
    this.sawdustInStore,
    this.sawdustUsed,
    this.sawdustRemaining,
  });

  factory BatchRecord.fromJson(Map<String, dynamic> json) {
    print('BatchRecord.fromJson - Raw JSON: $json');
    print(
      'BatchRecord.fromJson - feeds_used type: ${json['feeds_used']?.runtimeType}',
    );
    print(
      'BatchRecord.fromJson - vaccines_used type: ${json['vaccines_used']?.runtimeType}',
    );
    print(
      'BatchRecord.fromJson - other_materials_used type: ${json['other_materials_used']?.runtimeType}',
    );
    print('BatchRecord.fromJson - feeds_used value: ${json['feeds_used']}');
    print(
      'BatchRecord.fromJson - vaccines_used value: ${json['vaccines_used']}',
    );
    print(
      'BatchRecord.fromJson - other_materials_used value: ${json['other_materials_used']}',
    );

    return BatchRecord(
      id: json['id'] as String,
      dailyRecordId: json['daily_record_id'] as String,
      batchId: json['batch_id'] as String,
      chickenReduction: json['chicken_reduction'] as bool? ?? false,
      chickensSold: json['chickens_sold'] as int? ?? 0,
      chickensCurled: json['chickens_curled'] as int? ?? 0,
      chickensDied: json['chickens_died'] as int? ?? 0,
      chickensStolen: json['chickens_stolen'] as int? ?? 0,
      eggsCollected: json['eggs_collected'] as int?,
      gradeEggs: json['grade_eggs'] as bool? ?? false,
      eggsSmall: json['eggs_small'] as int?,
      eggsDeformed: json['eggs_deformed'] as int?,
      eggsStandard: json['eggs_standard'] as int?,
      feedUsedKg: (json['feed_used_kg'] as num?)?.toDouble(),
      vaccinesGiven: json['vaccines_given'] as String?,
      notes: json['notes'] as String?,
      feedsUsed: _parseFeedUsage(json['feeds_used']),
      vaccinesUsed: _parseVaccineUsage(json['vaccines_used']),
      otherMaterialsUsed: _parseOtherMaterialUsage(
        json['other_materials_used'],
      ),
      eggsBroken: json['eggs_broken'] as int?,
      sawdustInStore: json['sawdust_in_store'] as int?,
      sawdustUsed: json['sawdust_used'] as int?,
      sawdustRemaining: json['sawdust_remaining'] as int?,
    );
  }

  static List<FeedUsage> _parseFeedUsage(dynamic raw) {
    if (raw == null) return [];
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded.map((e) => FeedUsage.fromJson(e)).toList();
        }
      } catch (_) {}
      return [];
    }
    if (raw is List) {
      return raw.map((e) => FeedUsage.fromJson(e)).toList();
    }
    return [];
  }

  static List<VaccineUsage> _parseVaccineUsage(dynamic raw) {
    if (raw == null) return [];
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded.map((e) => VaccineUsage.fromJson(e)).toList();
        }
      } catch (_) {}
      return [];
    }
    if (raw is List) {
      return raw.map((e) => VaccineUsage.fromJson(e)).toList();
    }
    return [];
  }

  static List<OtherMaterialUsage> _parseOtherMaterialUsage(dynamic raw) {
    if (raw == null) return [];
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded.map((e) => OtherMaterialUsage.fromJson(e)).toList();
        }
      } catch (_) {}
      return [];
    }
    if (raw is List) {
      return raw.map((e) => OtherMaterialUsage.fromJson(e)).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'daily_record_id': dailyRecordId,
    'batch_id': batchId,
    'chicken_reduction': chickenReduction,
    'chickens_sold': chickensSold,
    'chickens_curled': chickensCurled,
    'chickens_died': chickensDied,
    'chickens_stolen': chickensStolen,
    'eggs_collected': eggsCollected,
    'grade_eggs': gradeEggs,
    'eggs_small': eggsSmall,
    'eggs_deformed': eggsDeformed,
    'eggs_standard': eggsStandard,
    'feed_used_kg': feedUsedKg,
    'vaccines_given': vaccinesGiven,
    'notes': notes,
    'feeds_used': feedsUsed.map((e) => e.toJson()).toList(),
    'vaccines_used': vaccinesUsed.map((e) => e.toJson()).toList(),
    'other_materials_used': otherMaterialsUsed.map((e) => e.toJson()).toList(),
    'eggs_broken': eggsBroken,
    'sawdust_in_store': sawdustInStore,
    'sawdust_used': sawdustUsed,
    'sawdust_remaining': sawdustRemaining,
  };

  static BatchRecord empty(String dailyRecordId, String batchId) => BatchRecord(
    id: const Uuid().v4(),
    dailyRecordId: dailyRecordId,
    batchId: batchId,
    chickenReduction: false,
    chickensSold: 0,
    chickensCurled: 0,
    chickensDied: 0,
    chickensStolen: 0,
    eggsCollected: null,
    gradeEggs: false,
    eggsSmall: null,
    eggsDeformed: null,
    eggsStandard: null,
    feedUsedKg: null,
    vaccinesGiven: null,
    notes: null,
    feedsUsed: [],
    vaccinesUsed: [],
    otherMaterialsUsed: [],
    eggsBroken: null,
    sawdustInStore: null,
    sawdustUsed: null,
    sawdustRemaining: null,
  );
}
