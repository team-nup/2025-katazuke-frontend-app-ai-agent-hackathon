import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory.dart';
import 'package:okataduke/features/components/memory_card.dart';
import 'package:okataduke/features/screen/memory_view/containers/memory_detail_container.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MemoryCard(
        memory: memory,
        showFullDetails: true,
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
      ),
    );
  }
}
