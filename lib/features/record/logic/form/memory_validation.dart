import '../../../../core/models/shared/memory.dart';

class MemoryValidation {
  static String? validateTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'タイトルを入力してください';
    }
    if (title.length > 100) {
      return 'タイトルは100文字以内で入力してください';
    }
    return null;
  }

  static String? validateDetail(String? detail) {
    if (detail != null && detail.length > 1000) {
      return '詳細は1000文字以内で入力してください';
    }
    return null;
  }

  static String? validateAges(int? startAge, int? endAge) {
    if (startAge != null && (startAge < 0)) {
      return '年齢は0歳から入力してください';
    }
    if (endAge != null && (endAge < 0)) {
      return '年齢は0歳から入力してください';
    }
    if (startAge != null && endAge != null && startAge > endAge) {
      return '開始年齢は終了年齢より小さい値を入力してください';
    }
    return null;
  }

  static bool isValid({
    required String? title,
    String? detail,
    int? startAge,
    int? endAge,
  }) {
    return validateTitle(title) == null &&
        validateDetail(detail) == null &&
        validateAges(startAge, endAge) == null;
  }

  static List<String> getAllValidationErrors({
    required String? title,
    String? detail,
    int? startAge,
    int? endAge,
  }) {
    final List<String> errors = [];

    final titleError = validateTitle(title);
    if (titleError != null) errors.add(titleError);

    final detailError = validateDetail(detail);
    if (detailError != null) errors.add(detailError);

    final ageError = validateAges(startAge, endAge);
    if (ageError != null) errors.add(ageError);

    return errors;
  }
}
