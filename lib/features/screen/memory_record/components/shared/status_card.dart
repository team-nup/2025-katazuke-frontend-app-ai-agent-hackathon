import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../../../../../core/models/DB/memory_status.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.inventory,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '思い出をどうする？',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
          title: '保管する',
          subtitle: '手元におく思い出の品',
          icon: Icons.home,
          value: MemoryStatus.keeping,
          isSelected: status == MemoryStatus.keeping,
        ),
        const SizedBox(height: 12),
        _buildStatusOption(
          title: '処分する',
          subtitle: '手放す思い出の品',
          icon: Icons.check_circle,
          value: MemoryStatus.disposed,
          isSelected: status == MemoryStatus.disposed,
        ),
      ],
    );
  }

  Widget _buildStatusOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required MemoryStatus value,
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
