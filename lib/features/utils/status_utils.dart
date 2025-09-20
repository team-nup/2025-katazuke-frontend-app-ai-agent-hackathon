import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory_status.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';

class StatusOption<T> {
  final String title;
  final String subtitle;
  final IconData icon;
  final T value;

  const StatusOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
  });
}

class StatusUtils {
  /// メモリステータスのオプション一覧
  static const List<StatusOption<MemoryStatus>> memoryStatusOptions = [
    StatusOption<MemoryStatus>(
      title: '保管する',
      subtitle: '手元におく思い出の品',
      icon: Icons.home,
      value: MemoryStatus.keeping,
    ),
    StatusOption<MemoryStatus>(
      title: '処分する',
      subtitle: '手放す思い出の品',
      icon: Icons.check_circle,
      value: MemoryStatus.disposed,
    ),
  ];

  /// アイテム保管ステータスのオプション一覧
  static const List<StatusOption<ItemKeepStatus>> itemStatusOptions = [
    StatusOption<ItemKeepStatus>(
      title: '検討中',
      subtitle: '売却を検討している商品',
      icon: Icons.help_outline,
      value: ItemKeepStatus.considering,
    ),
    StatusOption<ItemKeepStatus>(
      title: '売却する',
      subtitle: '売却予定の商品',
      icon: Icons.check_circle,
      value: ItemKeepStatus.disposed,
    ),
  ];

  /// メモリステータスの表示情報を取得
  static Map<String, dynamic> getMemoryStatusInfo(MemoryStatus status) {
    switch (status) {
      case MemoryStatus.keeping:
        return {
          'title': '保管中',
          'subtitle': '手元においている思い出の品',
          'icon': Icons.home,
          'color': 'primary',
        };
      case MemoryStatus.disposed:
        return {
          'title': '処分済み',
          'subtitle': '手放した思い出の品',
          'icon': Icons.check_circle,
          'color': 'success',
        };
    }
  }

  /// アイテム保管ステータスの表示情報を取得
  static Map<String, dynamic> getItemStatusInfo(ItemKeepStatus status) {
    switch (status) {
      case ItemKeepStatus.considering:
        return {
          'title': '検討中',
          'subtitle': '売却を検討している商品',
          'icon': Icons.help_outline,
          'color': 'primary',
        };
      case ItemKeepStatus.disposed:
        return {
          'title': '売却予定',
          'subtitle': '売却予定の商品',
          'icon': Icons.check_circle,
          'color': 'success',
        };
      case ItemKeepStatus.keeping:
        return {
          'title': '保管中',
          'subtitle': '手元に保管している商品',
          'icon': Icons.home,
          'color': 'primary',
        };
    }
  }
}
