import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/models/DB/value_search.dart';

class ValueSearchFactory {
  static const _uuid = Uuid();

  static ValueSearch createFromForm({
    String? productNameHint,
    required List<String> imagePaths,
    required int value,
    required ItemKeepStatus status,
    required String detectedProductName,
    required int aiConfidenceScore,
  }) {
    final now = DateTime.now();

    return ValueSearch(
      id: _uuid.v4(),
      productNameHint: productNameHint?.isEmpty == true ? null : productNameHint?.trim(),
      imagePaths: List<String>.from(imagePaths),
      value: value,
      status: status,
      detectedProductName: detectedProductName,
      aiConfidenceScore: aiConfidenceScore,
      disposedAt: status == ItemKeepStatus.disposed ? now : null,
      insertedAt: now,
      updatedAt: now,
    );
  }
}
