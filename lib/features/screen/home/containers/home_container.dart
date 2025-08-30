import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory.dart';
import '../../../../core/database/repositories/memory_repository.dart';
import '../../../../core/database/repositories/value_search_repository.dart';
import '../../memory_view/containers/memory_detail_container.dart';
import '../pages/home_page.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  Map<String, int> _statistics = {};
  List<Memory> _recentMemories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() => _isLoading = true);

    try {
      final results = await Future.wait([
        MemoryRepository.getStatistics(),
        ValueSearchRepository.getStatistics(),
        MemoryRepository.getRecentMemories(),
      ]);

      final memoryStatistics = results[0] as Map<String, int>;
      final valueSearchStatistics = results[1] as Map<String, int>;
      final recentMemories = results[2] as List<Memory>;

      final combinedStatistics = Map<String, int>.from(memoryStatistics);
      combinedStatistics['valueSearchConsidering'] =
          valueSearchStatistics['considering'] ?? 0;
      combinedStatistics['valueSearchDisposed'] =
          valueSearchStatistics['disposed'] ?? 0;

      setState(() {
        _statistics = combinedStatistics;
        _recentMemories = recentMemories;
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

  Future<void> _onMemoryTap(Memory memory) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MemoryDetailContainer(memory: memory),
      ),
    );

    // 詳細ページから戻ってきた時に更新があれば再読み込み
    if (result == true) {
      _loadStatistics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      statistics: _statistics,
      recentMemories: _recentMemories,
      isLoading: _isLoading,
      onRefresh: _loadStatistics,
      onMemoryTap: _onMemoryTap,
    );
  }
}
