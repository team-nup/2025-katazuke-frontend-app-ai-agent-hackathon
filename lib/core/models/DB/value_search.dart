import 'dart:convert';
import 'item_keep_status.dart';

class ValueSearch {
  final String id;
  final String? productNameHint;
  final List<String> imagePaths;
  final int? value;
  final ItemKeepStatus status;
  final String? detectedProductName;
  final int? aiConfidenceScore;
  final DateTime? disposedAt;
  final DateTime insertedAt;
  final DateTime updatedAt;

  ValueSearch({
    required this.id,
    this.productNameHint,
    required this.imagePaths,
    this.value,
    this.status = ItemKeepStatus.keeping,
    this.detectedProductName,
    this.aiConfidenceScore,
    this.disposedAt,
    required this.insertedAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_name_hint': productNameHint,
      'image_paths': jsonEncode(imagePaths),
      'value': value,
      'status': status.name,
      'detected_product_name': detectedProductName,
      'ai_confidence_score': aiConfidenceScore,
      'disposed_at': disposedAt?.millisecondsSinceEpoch,
      'inserted_at': insertedAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  static ValueSearch fromMap(Map<String, dynamic> map) {
    return ValueSearch(
      id: map['id'],
      productNameHint: map['product_name_hint'],
      imagePaths: List<String>.from(jsonDecode(map['image_paths'])),
      value: map['value'],
      status: ItemKeepStatus.values.byName(map['status']),
      detectedProductName: map['detected_product_name'],
      aiConfidenceScore: map['ai_confidence_score'],
      disposedAt: map['disposed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['disposed_at'])
          : null,
      insertedAt: DateTime.fromMillisecondsSinceEpoch(map['inserted_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  ValueSearch copyWith({
    String? id,
    String? productNameHint,
    List<String>? imagePaths,
    int? value,
    ItemKeepStatus? status,
    String? detectedProductName,
    int? aiConfidenceScore,
    DateTime? disposedAt,
    DateTime? insertedAt,
    DateTime? updatedAt,
  }) {
    return ValueSearch(
      id: id ?? this.id,
      productNameHint: productNameHint ?? this.productNameHint,
      imagePaths: imagePaths ?? this.imagePaths,
      value: value ?? this.value,
      status: status ?? this.status,
      detectedProductName: detectedProductName ?? this.detectedProductName,
      aiConfidenceScore: aiConfidenceScore ?? this.aiConfidenceScore,
      disposedAt: disposedAt ?? this.disposedAt,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
