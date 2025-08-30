import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../core/models/DB/memory.dart';
import '../../../../../core/models/DB/memory_status.dart';
import '../../../../../core/database/repositories/memory_repository.dart';
import 'memory_validator.dart';
import 'memory_factory.dart';

class MemoryService {
  static Future<String> createMemory({
    required String title,
    String? detail,
    int? startAge,
    int? endAge,
    required List<String> imagePaths,
    required MemoryStatus status,
  }) async {
    // Validation
    final validationError = MemoryValidator.validateAll(
      title: title,
      detail: detail,
      startAge: startAge,
      endAge: endAge,
    );

    if (validationError != null) {
      throw Exception(validationError);
    }

    // Create Memory using factory
    final memory = MemoryFactory.createFromForm(
      title: title,
      detail: detail,
      startAge: startAge,
      endAge: endAge,
      imagePaths: imagePaths,
      status: status,
    );

    // Save to database
    return await MemoryRepository.insert(memory);
  }

  static Future<Memory> updateMemory({
    required Memory originalMemory,
    required String title,
    String? detail,
    int? startAge,
    int? endAge,
    required List<String> imagePaths,
    required List<String> imagesToDelete,
    required MemoryStatus status,
  }) async {
    // Validation
    final validationError = MemoryValidator.validateAll(
      title: title,
      detail: detail,
      startAge: startAge,
      endAge: endAge,
    );

    if (validationError != null) {
      throw Exception(validationError);
    }

    // Update Memory using copyWith
    final updatedMemory = originalMemory.copyWith(
      title: title.trim(),
      detail: detail?.isEmpty == true ? null : detail?.trim(),
      startAge: startAge,
      endAge: endAge,
      imagePaths: imagePaths,
      clearImagePaths: imagePaths.isEmpty,
      status: status,
      disposedAt: status == MemoryStatus.disposed
          ? (originalMemory.disposedAt ?? DateTime.now())
          : (status != MemoryStatus.disposed
              ? null
              : originalMemory.disposedAt),
      updatedAt: DateTime.now(),
    );

    // Save to database
    await MemoryRepository.update(updatedMemory);

    // Delete removed images
    await _deleteRemovedImages(imagesToDelete);

    return updatedMemory;
  }

  static Future<void> _deleteRemovedImages(List<String> imagesToDelete) async {
    for (final imagePath in imagesToDelete) {
      try {
        final file = File(imagePath);
        if (await file.exists()) {
          await file.delete();
          debugPrint('削除された画像: $imagePath');
        }
      } catch (e) {
        debugPrint('画像削除エラー: $e');
      }
    }
  }
}
