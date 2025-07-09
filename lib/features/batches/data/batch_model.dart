import 'package:uuid/uuid.dart';

class Batch {
  final String id;
  final String userId;
  final String name;
  final String birdType; // broiler, kienyeji, layer
  final int ageInDays;
  final int totalChickens;
  final DateTime createdAt;

  Batch({
    required this.id,
    required this.userId,
    required this.name,
    required this.birdType,
    required this.ageInDays,
    required this.totalChickens,
    required this.createdAt,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    birdType: json['bird_type'] as String,
    ageInDays: json['age_in_days'] as int,
    totalChickens: json['total_chickens'] as int,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'bird_type': birdType,
    'age_in_days': ageInDays,
    'total_chickens': totalChickens,
    'created_at': createdAt.toIso8601String(),
  };

  static Batch empty(String userId) => Batch(
    id: const Uuid().v4(),
    userId: userId,
    name: '',
    birdType: 'broiler',
    ageInDays: 0,
    totalChickens: 0,
    createdAt: DateTime.now(),
  );

  Batch copyWith({
    String? id,
    String? userId,
    String? name,
    String? birdType,
    int? ageInDays,
    int? totalChickens,
    DateTime? createdAt,
  }) {
    return Batch(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      birdType: birdType ?? this.birdType,
      ageInDays: ageInDays ?? this.ageInDays,
      totalChickens: totalChickens ?? this.totalChickens,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
