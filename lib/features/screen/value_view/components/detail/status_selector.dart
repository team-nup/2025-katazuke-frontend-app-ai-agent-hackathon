import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:okataduke/core/mappers/item_keep_status_mapper.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class StatusSelector extends StatelessWidget {
  final ItemKeepStatus currentStatus;
  final Function(ItemKeepStatus)? onStatusChanged;

  const StatusSelector({
    super.key,
    required this.currentStatus,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '管理状態',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        _buildStatusOption(
          title: '検討中',
          subtitle: '売却検討中の商品です',
          icon: Icons.inventory_2_outlined,
          isSelected: currentStatus == ItemKeepStatus.considering,
          onTap: () => onStatusChanged?.call(ItemKeepStatus.considering),
        ),
        const SizedBox(height: 12),
        _buildStatusOption(
          title: '処分済',
          subtitle: '既に処分されている商品です',
          icon: Icons.delete_outline,
          isSelected: currentStatus == ItemKeepStatus.disposed,
          onTap: () => onStatusChanged?.call(ItemKeepStatus.disposed),
        ),
      ],
    );
  }

  Widget _buildStatusOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.card.withOpacity(0.3),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.textDisabled.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected ? AppColors.primary : AppColors.textDisabled,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
