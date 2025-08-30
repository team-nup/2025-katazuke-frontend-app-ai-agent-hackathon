import '../models/DB/item_keep_status.dart';

class ItemKeepStatusMapper {
  static String toDisplayString(ItemKeepStatus status) {
    switch (status) {
      case ItemKeepStatus.keeping:
        return '保管中';
      case ItemKeepStatus.considering:
        return '検討中';
      case ItemKeepStatus.disposed:
        return '処分済み';
    }
  }

  static ItemKeepStatus fromString(String statusString) {
    switch (statusString) {
      case 'keeping':
        return ItemKeepStatus.keeping;
      case 'considering':
        return ItemKeepStatus.considering;
      case 'disposed':
        return ItemKeepStatus.disposed;
      default:
        return ItemKeepStatus.keeping;
    }
  }
}