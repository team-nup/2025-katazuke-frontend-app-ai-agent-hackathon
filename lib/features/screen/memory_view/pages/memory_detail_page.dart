import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory.dart';
import '../components/detail/memory_info.dart';
import '../components/detail/memory_images.dart';
import '../../../components/app_bar.dart';

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
        appBar: AppBarComponent(
          title: '思い出詳細',
          titleIcon: Icons.info,
          showBackButton: true,
          actions: [
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              tooltip: '削除',
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (memory.imagePaths != null &&
                  memory.imagePaths!.isNotEmpty) ...[
                MemoryImages(imagePaths: memory.imagePaths!),
                const SizedBox(height: 16),
              ],
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MemoryInfo(memory: memory),
              ),
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
