import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../utils/status_utils.dart';

class StatusCard<T> extends StatelessWidget {
  final String title;
  final IconData? titleIcon;
  final T currentStatus;
  final List<StatusOption<T>> options;
  final Function(T) onStatusChanged;
  final bool isDisplayMode; // 表示専用モード（選択不可）

  const StatusCard({
    super.key,
    required this.title,
    this.titleIcon,
    required this.currentStatus,
    required this.options,
    required this.onStatusChanged,
    this.isDisplayMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppColors.accentHeart.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surface,
        ),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (titleIcon != null) ...[
                  Icon(
                    titleIcon!,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSelectionMode(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionMode() {
    return Column(
      children: options.map((option) {
        final isSelected = option.value == currentStatus;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildStatusOption(
            option: option,
            isSelected: isSelected,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusOption({
    required StatusOption<T> option,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: isDisplayMode ? null : () => onStatusChanged(option.value),
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
                option.icon,
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
                    option.title,
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
                    option.subtitle,
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
