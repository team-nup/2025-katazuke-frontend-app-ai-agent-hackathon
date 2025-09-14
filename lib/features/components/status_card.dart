import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/core/models/DB/memory_status.dart';

class StatusCard extends StatelessWidget {
  final MemoryStatus status;
  final String? customMessage;

  const StatusCard({
    super.key,
    required this.status,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isDisposed = status.name == 'disposed';
    final statusColor = isDisposed ? AppColors.success : AppColors.primary;
    final statusMessage = customMessage ?? 
        (isDisposed ? '手放した思い出として、心に刻まれています' : 'まだあなたのそばにある大切な思い出です');
    final statusEmoji = isDisposed ? '🌟' : '💝';
    final statusTitle = isDisposed ? '手放した思い出' : '大切に保管中';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              statusEmoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  statusMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}