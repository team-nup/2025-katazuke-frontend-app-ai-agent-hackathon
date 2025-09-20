import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../../../../../core/models/DB/memory.dart';
import '../../../../components/memory_card.dart';

class RecentMemoriesSection extends StatelessWidget {
  final List<Memory> memories;
  final Function(Memory)? onMemoryTap;

  const RecentMemoriesSection({
    super.key,
    required this.memories,
    this.onMemoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: AppColors.accentHeart,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                '最近の思い出',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (memories.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  size: 48,
                  color: AppColors.primary.withOpacity(0.6),
                ),
                const SizedBox(height: 12),
                Text(
                  'まだ思い出が保存されていません',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '「思い出を保存」から始めてみましょう',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textDisabled,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          Column(
            children: memories
                .map((memory) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MemoryCard(
                        memory: memory,
                        onTap: () => onMemoryTap?.call(memory),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
