import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory.dart';
import '../../../../components/status_card.dart' as CommonStatusCard;
import '../../../../utils/status_utils.dart';

class MemoryStatusDisplay extends StatelessWidget {
  final Memory memory;

  const MemoryStatusDisplay({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return CommonStatusCard.StatusCard(
      title: 'ステータス',
      titleIcon: Icons.inventory,
      currentStatus: memory.status,
      options: StatusUtils.memoryStatusOptions,
      onStatusChanged: (_) {},
      isDisplayMode: true,
    );
  }
}
