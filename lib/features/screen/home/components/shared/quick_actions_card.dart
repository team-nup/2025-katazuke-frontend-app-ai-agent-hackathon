import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class QuickActionsCard extends StatelessWidget {
  final VoidCallback onSaveMemory;
  final VoidCallback onCheckValue;
  final VoidCallback onRandomMemory;

  const QuickActionsCard({
    super.key,
    required this.onSaveMemory,
    required this.onCheckValue,
    required this.onRandomMemory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.grey.withOpacity(0.2),
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
                  Icons.cleaning_services,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '今日の整理',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'どちらの作業を始めますか？',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: QuickActionItem(
                    onPressed: onSaveMemory,
                    icon: Icons.camera_alt,
                    title: '思い出を保存',
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: QuickActionItem(
                    onPressed: onCheckValue,
                    icon: Icons.search,
                    title: '価値を調べる',
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: QuickActionItem(
                onPressed: onRandomMemory,
                icon: Icons.shuffle,
                title: 'ランダムに思い出を閲覧',
                color: AppColors.success,
                isWide: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickActionItem extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String title;
  final Color color;
  final bool isWide;

  const QuickActionItem({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
    required this.color,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: isWide ? 4.0 : 2.2,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isWide
                  ? Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
