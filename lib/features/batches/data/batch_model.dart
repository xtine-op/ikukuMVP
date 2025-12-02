import 'package:uuid/uuid.dart';

class Batch {
  final String id;
  final String userId;
  final String name;
  final String birdType; // broiler, kienyeji, layer
  final int ageInDays;
  final int totalChickens;
  final double pricePerBird;
  final DateTime createdAt;

  Batch({
    required this.id,
    required this.userId,
    required this.name,
    required this.birdType,
    required this.ageInDays,
    required this.totalChickens,
    required this.pricePerBird,
    required this.createdAt,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    birdType: json['bird_type'] as String,
    ageInDays: json['age_in_days'] as int,
    totalChickens: json['total_chickens'] as int,
    pricePerBird: (json['price_per_bird'] as num?)?.toDouble() ?? 0.0,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'bird_type': birdType,
    'age_in_days': ageInDays,
    'total_chickens': totalChickens,
    'price_per_bird': pricePerBird,
    'created_at': createdAt.toIso8601String(),
  };

  static Batch empty(String userId) => Batch(
    id: const Uuid().v4(),
    userId: userId,
    name: '',
    birdType: 'broiler',
    ageInDays: 0,
    totalChickens: 0,
    pricePerBird: 0.0,
    createdAt: DateTime.now(),
  );

  /// Calculate the current age of the birds in days based on creation date
  int get currentAgeInDays {
    final now = DateTime.now();
    final daysSinceCreation = now.difference(createdAt).inDays;
    return ageInDays + daysSinceCreation;
  }

  Batch copyWith({
    String? name,
    String? birdType,
    int? ageInDays,
    int? totalChickens,
    double? pricePerBird,
    DateTime? createdAt,
  }) {
    return Batch(
      id: id,
      userId: userId,
      name: name ?? this.name,
      birdType: birdType ?? this.birdType,
      ageInDays: ageInDays ?? this.ageInDays,
      totalChickens: totalChickens ?? this.totalChickens,
      pricePerBird: pricePerBird ?? this.pricePerBird,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
