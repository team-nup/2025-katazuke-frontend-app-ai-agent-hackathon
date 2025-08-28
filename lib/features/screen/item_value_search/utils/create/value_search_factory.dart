import 'package:uuid/uuid.dart';
import '../../../../../core/models/DB/value_search.dart';
import '../../../../../core/models/DB/memory_status.dart';

class ValueSearchFactory {
  static const _uuid = Uuid();

  static ValueSearch createFromForm({
    required String title,
    String? detail,
    required List<String> imagePaths,
    required int value,
    required ItemKeepStatus status,
    required String detectedProductName,
    required int aiConfidenceScore,
    int? minPrice,
    int? maxPrice,
  }) {
    final now = DateTime.now();

    return ValueSearch(
      id: _uuid.v4(),
      title: title.trim(),
      detail: detail?.isEmpty == true ? null : detail?.trim(),
      imagePaths: List<String>.from(imagePaths),
      value: value,
      status: status,
      detectedProductName: detectedProductName,
      aiConfidenceScore: aiConfidenceScore,
      minPrice: minPrice,
      maxPrice: maxPrice,
      disposedAt: status == ItemKeepStatus.disposed ? now : null,
      insertedAt: now,
      updatedAt: now,
    );
  }
}
