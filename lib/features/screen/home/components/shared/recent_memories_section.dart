import 'package:flutter/material.dart';
import '../../../../../core/models/DB/memory.dart';
import '../../utils/shared/date_formatter.dart';

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
        const Text('最近の思い出', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 16),
        if (memories.isEmpty)
          const Text('まだ思い出が保存されていません')
        else
          Column(
            children: memories
                .map((memory) => ListTile(
                      title: Text(memory.title),
                      subtitle: Text(
                          '${memory.status.name} - ${DateFormatter.formatRelativeDate(memory.insertedAt)}'),
                      onTap: () => onMemoryTap?.call(memory),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
