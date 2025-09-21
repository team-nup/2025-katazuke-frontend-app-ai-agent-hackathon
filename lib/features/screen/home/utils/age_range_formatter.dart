class AgeRangeFormatter {
  /// 年齢範囲を適切な文字列にフォーマットする
  static String formatAgeRange(int? startAge, int? endAge) {
    if (startAge != null && endAge != null) {
      return '${startAge}-${endAge}歳';
    } else if (startAge != null) {
      return '${startAge}歳から';
    } else if (endAge != null) {
      return '${endAge}歳まで';
    } else {
      return '';
    }
  }
}
