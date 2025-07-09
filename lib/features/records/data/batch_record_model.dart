import 'package:uuid/uuid.dart';

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
  });

  factory BatchRecord.fromJson(Map<String, dynamic> json) => BatchRecord(
    id: json['id'] as String,
    dailyRecordId: json['daily_record_id'] as String,
    batchId: json['batch_id'] as String,
    chickenReduction: json['chicken_reduction'] as bool,
    chickensSold: json['chickens_sold'] as int,
    chickensCurled: json['chickens_curled'] as int,
    chickensDied: json['chickens_died'] as int,
    chickensStolen: json['chickens_stolen'] as int,
    eggsCollected: json['eggs_collected'] as int?,
    gradeEggs: json['grade_eggs'] as bool,
    eggsSmall: json['eggs_small'] as int?,
    eggsDeformed: json['eggs_deformed'] as int?,
    eggsStandard: json['eggs_standard'] as int?,
    feedUsedKg: (json['feed_used_kg'] as num?)?.toDouble(),
    vaccinesGiven: json['vaccines_given'] as String?,
    notes: json['notes'] as String?,
  );

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
  );
}
