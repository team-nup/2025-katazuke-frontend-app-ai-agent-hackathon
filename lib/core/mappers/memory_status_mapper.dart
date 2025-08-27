import '../models/DB/memory_status.dart';

class MemoryStatusMapper {
  static String toDisplayString(ItemKeepStatus status) {
    switch (status) {
      case ItemKeepStatus.keeping:
        return '保管中';
      case ItemKeepStatus.disposed:
        return '処分済み';
      case ItemKeepStatus.considering:
        return '検討中';
    }
  }

  static String toDbString(ItemKeepStatus status) {
    return status.name;
  }

  static ItemKeepStatus fromDbString(String value) {
    return ItemKeepStatus.values.byName(value);
  }
}
