import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory.dart';
import '../../containers/memory_detail_container.dart';

class MemoryItem extends StatelessWidget {
  final Memory memory;
  final VoidCallback? onTap;

  const MemoryItem({
    super.key,
    required this.memory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          final hasBeenUpdated = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (context) => MemoryDetailContainer(memory: memory),
            ),
          );
          // 更新があった場合のみコールバックを実行
          if (hasBeenUpdated == true) {
            onTap?.call();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (memory.imagePaths != null && memory.imagePaths!.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: memory.imagePaths!.length,
                  itemBuilder: (context, index) {
                    final imagePath = memory.imagePaths![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.file(
                        File(imagePath),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memory.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (memory.detail != null) ...[
                    Text(
                      memory.detail!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (memory.startAge != null || memory.endAge != null) ...[
                    Text(
                      '年齢: ${memory.startAge ?? '?'}歳 - ${memory.endAge ?? '?'}歳',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    'ステータス: ${memory.status.name}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '保存日: ${memory.insertedAt.year}/${memory.insertedAt.month}/${memory.insertedAt.day}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
