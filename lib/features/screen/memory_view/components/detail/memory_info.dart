import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../../utils/detail/memory_formatter.dart';

class MemoryInfo extends StatelessWidget {
  final Memory memory;

  const MemoryInfo({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // メインタイトル - 大きく目立つ
        Text(
          memory.title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
        ),

        // 年齢情報 - さりげなく表示
        if (memory.startAge != null || memory.endAge != null) ...[
          const SizedBox(height: 8),
          Text(
            '${MemoryFormatter.formatAgeRange(memory)}の頃',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],

        const SizedBox(height: 24),

        // 思い出の詳細 - 読みやすく配置
        if (memory.detail != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              memory.detail!,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],

        // ステータス情報 - コンパクトに
        _buildSimpleStatusRow(),
        const SizedBox(height: 16),

        // 日付情報 - さりげなく
        _buildDateInfo(),
      ],
    );
  }

  Widget _buildSimpleStatusRow() {
    final isDisposed = memory.status.name == 'disposed';
    final statusColor = isDisposed ? AppColors.success : AppColors.primary;
    final statusText = isDisposed ? '手放した思い出' : '大切に保管中';
    final statusIcon = isDisposed ? Icons.star : Icons.favorite;

    return Row(
      children: [
        Icon(
          statusIcon,
          color: statusColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          statusText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: statusColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDateInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                '保存日',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                MemoryFormatter.formatDate(memory.insertedAt),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          if (memory.disposedAt != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.event_available,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  '手放した日',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  MemoryFormatter.formatDate(memory.disposedAt!),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
