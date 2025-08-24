import '../models/shared/memory_status.dart';

class MemoryStatusMapper {
  static String toDisplayString(MemoryStatus status) {
    switch (status) {
      case MemoryStatus.keeping:
        return '保管中';
      case MemoryStatus.disposed:
        return '処分済み';
      case MemoryStatus.considering:
        return '検討中';
    }
  }

  static String toDbString(MemoryStatus status) {
    return status.name;
  }

  static MemoryStatus fromDbString(String value) {
    return MemoryStatus.values.byName(value);
  }
}