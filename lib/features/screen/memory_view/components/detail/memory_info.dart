import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory.dart';
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
        // タイトル
        Text(
          'タイトル',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          memory.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),

        // 詳細
        if (memory.detail != null) ...[
          Text(
            '詳細',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(
            memory.detail!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],

        // 年齢範囲
        if (memory.startAge != null || memory.endAge != null) ...[
          Text(
            '年齢',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(
            MemoryFormatter.formatAgeRange(memory),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],

        // ステータス
        Text(
          'ステータス',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          memory.status.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),

        // 処分日
        if (memory.disposedAt != null) ...[
          Text(
            '処分日',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(
            MemoryFormatter.formatDate(memory.disposedAt!),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],

        // 作成日・更新日
        Text(
          '作成日',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          MemoryFormatter.formatDate(memory.insertedAt),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),

        Text(
          '更新日',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          MemoryFormatter.formatDate(memory.updatedAt),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
