import 'package:flutter/material.dart';
import '../../../core/models/shared/memory.dart';
import 'components/memory_info.dart';
import 'components/memory_images.dart';

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
            MemoryInfo(memory: memory),
            if (memory.imagePaths != null && memory.imagePaths!.isNotEmpty) ...[
              const SizedBox(height: 16),
              MemoryImages(imagePaths: memory.imagePaths!),
            ],
          ],
        ),
      ),
    );
  }
}
