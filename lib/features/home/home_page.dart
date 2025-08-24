import 'package:flutter/material.dart';
import '../../core/database/repositories/memory_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> _statistics = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() => _isLoading = true);

    try {
      final statistics = await MemoryRepository.getStatistics();
      setState(() {
        _statistics = statistics;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラー: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('思い出の統計', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else ...[
              Text('保存した思い出: ${_statistics['total'] ?? 0}件'),
              Text('保管中: ${_statistics['keeping'] ?? 0}件'),
              Text('検討中: ${_statistics['considering'] ?? 0}件'),
              Text('処分済み: ${_statistics['disposed'] ?? 0}件'),
            ],
          ],
        ),
      ),
    );
  }
}
