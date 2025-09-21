class DateFormatter {
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return '今日';
    } else if (difference == 1) {
      return '昨日';
    } else if (difference < 7) {
      return '${difference}日前';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return '${weeks}週間前';
    } else if (difference < 365) {
      final months = (difference / 30).floor();
      return '${months}ヶ月前';
    } else {
      final years = (difference / 365).floor();
      return '${years}年前';
    }
  }
}
