import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory.dart';
import '../../../../core/database/repositories/memory_repository.dart';
import '../pages/memory_page.dart';

class MemoryContainer extends StatefulWidget {
  const MemoryContainer({super.key});

  @override
  State<MemoryContainer> createState() => _MemoryContainerState();
}

class _MemoryContainerState extends State<MemoryContainer> {
  List<Memory> _memories = [];
  bool _isLoading = true;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  Future<void> _loadMemories() async {
    setState(() => _isLoading = true);

    try {
      final totalCount = await MemoryRepository.count();
      final memories = await MemoryRepository.findAll();

      setState(() {
        _memories = memories;
        _totalCount = totalCount;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('データ読み込みエラー: $e')),
        );
      }
    }
  }

  void _onMemoryUpdated() {
    _loadMemories();
  }

  @override
  Widget build(BuildContext context) {
    return MemoryPage(
      memories: _memories,
      isLoading: _isLoading,
      totalCount: _totalCount,
      onRefresh: _loadMemories,
      onMemoryUpdated: _onMemoryUpdated,
    );
  }
}
