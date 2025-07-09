import 'package:uuid/uuid.dart';

class InventoryItem {
  final String id;
  final String userId;
  final String name;
  final String category; // feed, vaccine, medicine, other
  final int quantity;
  final String unit;
  final DateTime addedOn;

  InventoryItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.addedOn,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    quantity: json['quantity'] as int,
    unit: json['unit'] as String,
    addedOn: DateTime.parse(json['added_on'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'category': category,
    'quantity': quantity,
    'unit': unit,
    'added_on': addedOn.toIso8601String(),
  };

  static InventoryItem empty(String userId) => InventoryItem(
    id: const Uuid().v4(),
    userId: userId,
    name: '',
    category: 'feed',
    quantity: 0,
    unit: 'kg',
    addedOn: DateTime.now(),
  );

  InventoryItem copyWith({
    String? id,
    String? userId,
    String? name,
    String? category,
    int? quantity,
    String? unit,
    DateTime? addedOn,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      addedOn: addedOn ?? this.addedOn,
    );
  }
}
