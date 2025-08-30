import 'dart:convert';
import 'memory_status.dart';

class Memory {
  final String id;
  final String title;
  final String? detail;
  final int? startAge;
  final int? endAge;
  final List<String>? imagePaths;
  final MemoryStatus status;
  final DateTime? disposedAt;
  final DateTime insertedAt;
  final DateTime updatedAt;

  Memory({
    required this.id,
    required this.title,
    this.detail,
    this.startAge,
    this.endAge,
    this.imagePaths,
    this.status = MemoryStatus.disposed,
    this.disposedAt,
    required this.insertedAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'start_age': startAge,
      'end_age': endAge,
      'image_paths': imagePaths != null ? jsonEncode(imagePaths) : null,
      'status': status.name,
      'disposed_at': disposedAt?.millisecondsSinceEpoch,
      'inserted_at': insertedAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  static Memory fromMap(Map<String, dynamic> map) {
    return Memory(
      id: map['id'],
      title: map['title'],
      detail: map['detail'],
      startAge: map['start_age'],
      endAge: map['end_age'],
      imagePaths: map['image_paths'] != null
          ? List<String>.from(jsonDecode(map['image_paths']))
          : null,
      status: MemoryStatus.values.byName(map['status']),
      disposedAt: map['disposed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['disposed_at'])
          : null,
      insertedAt: DateTime.fromMillisecondsSinceEpoch(map['inserted_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  Memory copyWith({
    String? id,
    String? title,
    String? detail,
    int? startAge,
    int? endAge,
    List<String>? imagePaths,
    bool clearImagePaths = false,
    MemoryStatus? status,
    DateTime? disposedAt,
    DateTime? insertedAt,
    DateTime? updatedAt,
  }) {
    return Memory(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      startAge: startAge ?? this.startAge,
      endAge: endAge ?? this.endAge,
      imagePaths: clearImagePaths ? null : (imagePaths ?? this.imagePaths),
      status: status ?? this.status,
      disposedAt: disposedAt ?? this.disposedAt,
      insertedAt: insertedAt ?? this.insertedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
