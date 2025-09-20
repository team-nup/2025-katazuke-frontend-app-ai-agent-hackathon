import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/core/models/DB/memory.dart';
import '../../../../utils/age_utils.dart';

class MemoryUsagePeriod extends StatelessWidget {
  final Memory memory;

  const MemoryUsagePeriod({
    super.key,
    required this.memory,
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
                Icon(
                  Icons.schedule,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '使用期間',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (memory.startAge != null) ...[
                  _buildAgeIcon(memory.startAge!),
                ],
                if (memory.startAge != null && memory.endAge != null) ...[
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                if (memory.endAge != null) ...[
                  _buildAgeIcon(memory.endAge!),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeIcon(int age) {
    final ageInfo = AgeUtils.getAgeStageInfo(age);
    final icon = ageInfo['icon'] as IconData;
    final label = ageInfo['label'] as String;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            size: 32,
            color: AppColors.iconGreen,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${age}歳',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
