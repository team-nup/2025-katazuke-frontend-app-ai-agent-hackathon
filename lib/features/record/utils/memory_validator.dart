class MemoryValidator {
  static String? validateTitle(String title) {
    if (title.trim().isEmpty) {
      return 'タイトルは必須です';
    }
    if (title.trim().length > 100) {
      return 'タイトルは100文字以内で入力してください';
    }
    return null;
  }

  static String? validateDetail(String? detail) {
    if (detail != null && detail.trim().length > 1000) {
      return '詳細は1000文字以内で入力してください';
    }
    return null;
  }

  static String? validateAges(int? startAge, int? endAge) {
    if (startAge != null && (startAge < 0 || startAge > 150)) {
      return '開始年齢は0-150の範囲で入力してください';
    }
    if (endAge != null && (endAge < 0 || endAge > 150)) {
      return '終了年齢は0-150の範囲で入力してください';
    }
    if (startAge != null && endAge != null && startAge > endAge) {
      return '開始年齢は終了年齢以下にしてください';
    }
    return null;
  }

  static String? validateAll({
    required String title,
    String? detail,
    int? startAge,
    int? endAge,
  }) {
    return validateTitle(title) ??
        validateDetail(detail) ??
        validateAges(startAge, endAge);
  }
}