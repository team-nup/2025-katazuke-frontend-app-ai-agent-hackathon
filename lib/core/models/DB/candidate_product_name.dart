import 'package:uuid/uuid.dart';

class CandidateProductName {
  final String id;
  final String valueSearchId;
  final int rank;
  final String productName;
  final double confidence;
  final DateTime insertedAt;
  final DateTime updatedAt;

  CandidateProductName({
    required this.id,
    required this.valueSearchId,
    required this.rank,
    required this.productName,
    required this.confidence,
    required this.insertedAt,
    required this.updatedAt,
  });

  factory CandidateProductName.create({
    required String valueSearchId,
    required int rank,
    required String productName,
    required double confidence,
  }) {
    final now = DateTime.now();
    return CandidateProductName(
      id: const Uuid().v4(),
      valueSearchId: valueSearchId,
      rank: rank,
      productName: productName,
      confidence: confidence,
      insertedAt: now,
      updatedAt: now,
    );
  }

  factory CandidateProductName.fromMap(Map<String, dynamic> map) {
    return CandidateProductName(
      id: map['id'],
      valueSearchId: map['value_search_id'],
      rank: map['rank'],
      productName: map['product_name'],
      confidence: map['confidence'],
      insertedAt: DateTime.fromMillisecondsSinceEpoch(map['inserted_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value_search_id': valueSearchId,
      'rank': rank,
      'product_name': productName,
      'confidence': confidence,
      'inserted_at': insertedAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  CandidateProductName copyWith({
    String? id,
    String? valueSearchId,
    int? rank,
    String? productName,
    double? confidence,
    DateTime? insertedAt,
    DateTime? updatedAt,
  }) {
    return CandidateProductName(
      id: id ?? this.id,
      valueSearchId: valueSearchId ?? this.valueSearchId,
      rank: rank ?? this.rank,
      productName: productName ?? this.productName,
      confidence: confidence ?? this.confidence,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}