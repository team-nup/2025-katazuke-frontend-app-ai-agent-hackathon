import 'package:flutter/material.dart';
import '../components/list/memory_list.dart';
import '../../../../core/models/DB/memory.dart';
import '../../../components/app_bar.dart';

class MemoryListPage extends StatelessWidget {
  final List<Memory> memories;
  final bool isLoading;
  final int totalCount;
  final VoidCallback onRefresh;
  final VoidCallback onMemoryUpdated;

  const MemoryListPage({
    super.key,
    required this.memories,
    required this.isLoading,
    required this.totalCount,
    required this.onRefresh,
    required this.onMemoryUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '思い出ボックス ($totalCount)',
        titleIcon: Icons.inventory,
      ),
      body: MemoryList(
        memories: memories,
        isLoading: isLoading,
        onRefresh: onRefresh,
        onMemoryUpdated: onMemoryUpdated,
      ),
    );
  }
}
