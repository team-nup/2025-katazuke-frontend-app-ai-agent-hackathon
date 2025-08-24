import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/models/shared/memory.dart';

class MemoryDetailPage extends StatelessWidget {
  final Memory memory;

  const MemoryDetailPage({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('思い出詳細'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                _formatAgeRange(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],

            // 画像
            if (memory.imagePaths != null && memory.imagePaths!.isNotEmpty) ...[
              Text(
                '画像',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              _buildImageGrid(),
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
                _formatDate(memory.disposedAt!),
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
              _formatDate(memory.insertedAt),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            Text(
              '更新日',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(memory.updatedAt),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _formatAgeRange() {
    if (memory.startAge != null && memory.endAge != null) {
      return '${memory.startAge}歳 〜 ${memory.endAge}歳';
    } else if (memory.startAge != null) {
      return '${memory.startAge}歳〜';
    } else if (memory.endAge != null) {
      return '〜${memory.endAge}歳';
    }
    return '';
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: memory.imagePaths!.length,
      itemBuilder: (context, index) {
        final imagePath = memory.imagePaths![index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
