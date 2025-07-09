import 'package:uuid/uuid.dart';

class DailyRecord {
  final String id;
  final String userId;
  final DateTime recordDate;
  final DateTime createdAt;

  DailyRecord({
    required this.id,
    required this.userId,
    required this.recordDate,
    required this.createdAt,
  });

  factory DailyRecord.fromJson(Map<String, dynamic> json) => DailyRecord(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    recordDate: DateTime.parse(json['record_date'] as String),
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'record_date': recordDate.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
  };

  static DailyRecord empty(String userId) => DailyRecord(
    id: const Uuid().v4(),
    userId: userId,
    recordDate: DateTime.now(),
    createdAt: DateTime.now(),
  );
}
