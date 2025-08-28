import 'package:okataduke/core/models/DB/memory.dart';

class MemoryFormatter {
  static String formatAgeRange(Memory memory) {
    if (memory.startAge != null && memory.endAge != null) {
      return '${memory.startAge}歳 〜 ${memory.endAge}歳';
    } else if (memory.startAge != null) {
      return '${memory.startAge}歳〜';
    } else if (memory.endAge != null) {
      return '〜${memory.endAge}歳';
    }
    return '';
  }

  static String formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
