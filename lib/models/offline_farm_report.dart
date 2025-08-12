import 'dart:convert';

class OfflineFarmReport {
  final String id;
  final Map<String, dynamic> reportData;
  final DateTime createdAt;

  OfflineFarmReport({
    required this.id,
    required this.reportData,
    required this.createdAt,
  });

  factory OfflineFarmReport.fromMap(Map<String, dynamic> map) =>
      OfflineFarmReport(
        id: map['id'] as String,
        reportData: Map<String, dynamic>.from(map['reportData'] as Map),
        createdAt: DateTime.parse(map['createdAt'] as String),
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'reportData': reportData,
    'createdAt': createdAt.toIso8601String(),
  };

  String toJson() => json.encode(toMap());
  factory OfflineFarmReport.fromJson(String source) =>
      OfflineFarmReport.fromMap(json.decode(source));
}
