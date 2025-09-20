import 'package:flutter/material.dart';
import '../../../../../core/models/DB/memory_status.dart';
import '../../../../components/status_card.dart' as CommonStatusCard;
import '../../../../utils/status_utils.dart';

class StatusCard extends StatelessWidget {
  final MemoryStatus status;
  final Function(MemoryStatus) onStatusChanged;

  const StatusCard({
    super.key,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CommonStatusCard.StatusCard<MemoryStatus>(
      title: '思い出をどうする？',
      titleIcon: Icons.inventory,
      currentStatus: status,
      options: StatusUtils.memoryStatusOptions,
      onStatusChanged: onStatusChanged,
    );
  }
}
