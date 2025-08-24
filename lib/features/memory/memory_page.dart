import 'package:flutter/material.dart';
import 'components/memory_list/ui/memory_list.dart';
import '../../core/database/repositories/memory_repository.dart';
import '../../core/models/shared/memory.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({super.key});

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('思い出 ($_totalCount件)'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: MemoryList(
        memories: _memories,
        isLoading: _isLoading,
        onRefresh: _loadMemories,
      ),
    );
  }
}
