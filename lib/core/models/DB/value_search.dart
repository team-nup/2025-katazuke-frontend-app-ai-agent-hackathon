import 'dart:convert';
import 'item_keep_status.dart';

class ValueSearch {
  final String id;
  final String title;
  final String? detail;
  final List<String> imagePaths;
  final int? value;
  final ItemKeepStatus status;
  final String? detectedProductName;
  final int? aiConfidenceScore;
  final int? minPrice;
  final int? maxPrice;
  final DateTime? disposedAt;
  final DateTime insertedAt;
  final DateTime updatedAt;

  ValueSearch({
    required this.id,
    required this.title,
    this.detail,
    required this.imagePaths,
    this.value,
    this.status = ItemKeepStatus.keeping,
    this.detectedProductName,
    this.aiConfidenceScore,
    this.minPrice,
    this.maxPrice,
    this.disposedAt,
    required this.insertedAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'image_paths': jsonEncode(imagePaths),
      'value': value,
      'status': status.name,
      'detected_product_name': detectedProductName,
      'ai_confidence_score': aiConfidenceScore,
      'min_price': minPrice,
      'max_price': maxPrice,
      'disposed_at': disposedAt?.millisecondsSinceEpoch,
      'inserted_at': insertedAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  static ValueSearch fromMap(Map<String, dynamic> map) {
    return ValueSearch(
      id: map['id'],
      title: map['title'],
      detail: map['detail'],
      imagePaths: List<String>.from(jsonDecode(map['image_paths'])),
      value: map['value'],
      status: ItemKeepStatus.values.byName(map['status']),
      detectedProductName: map['detected_product_name'],
      aiConfidenceScore: map['ai_confidence_score'],
      minPrice: map['min_price'],
      maxPrice: map['max_price'],
      disposedAt: map['disposed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['disposed_at'])
          : null,
      insertedAt: DateTime.fromMillisecondsSinceEpoch(map['inserted_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  ValueSearch copyWith({
    String? id,
    String? title,
    String? detail,
    List<String>? imagePaths,
    int? value,
    ItemKeepStatus? status,
    String? detectedProductName,
    int? aiConfidenceScore,
    int? minPrice,
    int? maxPrice,
    DateTime? disposedAt,
    DateTime? insertedAt,
    DateTime? updatedAt,
  }) {
    return ValueSearch(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      imagePaths: imagePaths ?? this.imagePaths,
      value: value ?? this.value,
      status: status ?? this.status,
      detectedProductName: detectedProductName ?? this.detectedProductName,
      aiConfidenceScore: aiConfidenceScore ?? this.aiConfidenceScore,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      disposedAt: disposedAt ?? this.disposedAt,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
