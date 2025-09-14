import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'package:okataduke/core/models/DB/candidate_product_name.dart';
import 'package:okataduke/core/models/service/product_candidate.dart';
import 'package:okataduke/core/database/repositories/value_search_repository.dart';
import 'package:okataduke/core/database/repositories/candidate_product_name_repository.dart';
import 'value_search_validator.dart';
import '../create/value_search_factory.dart';

class ValueSearchService {
  static Future<String> createValueSearch({
    String? productNameHint,
    required List<String> imagePaths,
    required int value,
    required ItemKeepStatus status,
    required String detectedProductName,
    required int aiConfidenceScore,
    List<ProductCandidate>? candidates,
  }) async {
    // Validation
    final validationError = ValueSearchValidator.validateAll(
      productNameHint: productNameHint,
      imagePaths: imagePaths,
      detectedProductName: detectedProductName,
    );

    if (validationError != null) {
      throw Exception(validationError);
    }

    // Create ValueSearch using factory
    final valueSearch = ValueSearchFactory.createFromForm(
      productNameHint: productNameHint,
      imagePaths: imagePaths,
      value: value,
      status: status,
      detectedProductName: detectedProductName,
      aiConfidenceScore: aiConfidenceScore,
    );

    // Save to database
    final valueSearchId = await ValueSearchRepository.insert(valueSearch);

    // Save candidate product names
    if (candidates != null && candidates.isNotEmpty) {
      final candidateModels = candidates.map((candidate) =>
        CandidateProductName.create(
          valueSearchId: valueSearchId,
          rank: candidate.rank,
          productName: candidate.name,
          confidence: candidate.confidence,
        )
      ).toList();

      await CandidateProductNameRepository.insertMultiple(candidateModels);
    }

    return valueSearchId;
  }

  static Future<ValueSearch> updateValueSearch({
    required ValueSearch originalValueSearch,
    String? productNameHint,
    required List<String> imagePaths,
    required int value,
    required ItemKeepStatus status,
    required String detectedProductName,
    required int aiConfidenceScore,
  }) async {
    // Validation
    final validationError = ValueSearchValidator.validateAll(
      productNameHint: productNameHint,
      imagePaths: imagePaths,
      detectedProductName: detectedProductName,
    );

    if (validationError != null) {
      throw Exception(validationError);
    }

    // Update ValueSearch using copyWith
    final updatedValueSearch = originalValueSearch.copyWith(
      productNameHint: productNameHint?.isEmpty == true ? null : productNameHint?.trim(),
      imagePaths: imagePaths,
      value: value,
      status: status,
      detectedProductName: detectedProductName,
      aiConfidenceScore: aiConfidenceScore,
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
