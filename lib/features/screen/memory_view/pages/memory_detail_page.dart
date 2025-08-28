import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory.dart';
import '../components/detail/memory_info.dart';
import '../components/detail/memory_images.dart';

class MemoryDetailPage extends StatelessWidget {
  final Memory memory;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final void Function(bool, dynamic) onPopInvoked;

  const MemoryDetailPage({
    super.key,
    required this.memory,
    required this.onEdit,
    required this.onDelete,
    required this.onPopInvoked,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: onPopInvoked,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('思い出詳細'),
          backgroundColor: Colors.teal.shade50,
          actions: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
              tooltip: '編集',
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              tooltip: '削除',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MemoryInfo(memory: memory),
              if (memory.imagePaths != null &&
                  memory.imagePaths!.isNotEmpty) ...[
                const SizedBox(height: 16),
                MemoryImages(imagePaths: memory.imagePaths!),
              ],
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onEdit,
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
