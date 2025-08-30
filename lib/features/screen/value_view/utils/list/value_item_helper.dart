import 'package:flutter/material.dart';
import '../../../../../core/models/DB/memory_status.dart';
import '../../../../../core/mappers/memory_status_mapper.dart';

class ValueItemHelper {
  static String formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  static Color getStatusColor(ItemKeepStatus status) {
    switch (status) {
      case ItemKeepStatus.keeping:
        return Colors.blue;
      case ItemKeepStatus.considering:
        return Colors.orange;
      case ItemKeepStatus.disposed:
        return Colors.grey;
    }
  }

  static String getStatusText(ItemKeepStatus status) {
    return MemoryStatusMapper.toDisplayString(status);
  }
}