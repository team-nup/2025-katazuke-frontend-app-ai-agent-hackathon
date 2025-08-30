import 'package:okataduke/core/models/DB/item_keep_status.dart';
import '../../../../../core/models/DB/value_search.dart';
import '../../../../../core/database/repositories/value_search_repository.dart';
import 'value_search_validator.dart';
import '../create/value_search_factory.dart';

class ValueSearchService {
  static Future<String> createValueSearch({
    required String title,
    String? detail,
    required List<String> imagePaths,
    required int value,
    required ItemKeepStatus status,
    required String detectedProductName,
    required int aiConfidenceScore,
    int? minPrice,
    int? maxPrice,
  }) async {
    // Validation
    final validationError = ValueSearchValidator.validateAll(
      title: title,
      detail: detail,
      imagePaths: imagePaths,
      detectedProductName: detectedProductName,
    );

    if (validationError != null) {
      throw Exception(validationError);
    }

    // Create ValueSearch using factory
    final valueSearch = ValueSearchFactory.createFromForm(
      title: title,
      detail: detail,
      imagePaths: imagePaths,
      value: value,
      status: status,
      detectedProductName: detectedProductName,
      aiConfidenceScore: aiConfidenceScore,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

    // Save to database
    return await ValueSearchRepository.insert(valueSearch);
  }

  static Future<ValueSearch> updateValueSearch({
    required ValueSearch originalValueSearch,
    required String title,
    String? detail,
    required List<String> imagePaths,
    required int value,
    required ItemKeepStatus status,
    required String detectedProductName,
    required int aiConfidenceScore,
    int? minPrice,
    int? maxPrice,
  }) async {
    // Validation
    final validationError = ValueSearchValidator.validateAll(
      title: title,
      detail: detail,
      imagePaths: imagePaths,
      detectedProductName: detectedProductName,
    );

    if (validationError != null) {
      throw Exception(validationError);
    }

    // Update ValueSearch using copyWith
    final updatedValueSearch = originalValueSearch.copyWith(
      title: title.trim(),
      detail: detail?.isEmpty == true ? null : detail?.trim(),
      imagePaths: imagePaths,
      value: value,
      status: status,
      detectedProductName: detectedProductName,
      aiConfidenceScore: aiConfidenceScore,
      minPrice: minPrice,
      maxPrice: maxPrice,
      disposedAt: status == ItemKeepStatus.disposed
          ? (originalValueSearch.disposedAt ?? DateTime.now())
          : (status != ItemKeepStatus.disposed
              ? null
              : originalValueSearch.disposedAt),
      updatedAt: DateTime.now(),
    );

    // Save to database
    await ValueSearchRepository.update(updatedValueSearch);

    return updatedValueSearch;
  }
}
