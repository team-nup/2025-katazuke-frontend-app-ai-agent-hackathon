import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';

class ValueStatusCard extends StatelessWidget {
  final ItemKeepStatus status;
  final Function(ItemKeepStatus) onStatusChanged;

  const ValueStatusCard({
    super.key,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surface,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.inventory_2,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '商品はどうする？',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatusOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOptions() {
    return Column(
      children: [
        _buildStatusOption(
          title: '検討中',
          subtitle: '売却を検討している商品',
          icon: Icons.help_outline,
          value: ItemKeepStatus.considering,
          isSelected: status == ItemKeepStatus.considering,
        ),
        const SizedBox(height: 12),
        _buildStatusOption(
          title: '売却する',
          subtitle: '売却予定の商品',
          icon: Icons.check_circle,
          value: ItemKeepStatus.disposed,
          isSelected: status == ItemKeepStatus.disposed,
        ),
      ],
    );
  }

  Widget _buildStatusOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required ItemKeepStatus value,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onStatusChanged(value),
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
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
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
