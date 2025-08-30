import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory.dart';
import '../components/shared/recent_memories_section.dart';
import '../components/shared/analytics_card.dart';
import '../../../components/app_bar.dart';

class HomePage extends StatelessWidget {
  final Map<String, int> statistics;
  final List<Memory> recentMemories;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(Memory) onMemoryTap;

  const HomePage({
    super.key,
    required this.statistics,
    required this.recentMemories,
    required this.isLoading,
    required this.onRefresh,
    required this.onMemoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: const AppBarComponent(
        title: 'ホーム',
        titleIcon: Icons.home,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnalyticsCard(statistics: statistics),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 24),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              RecentMemoriesSection(
                memories: recentMemories,
                onMemoryTap: onMemoryTap,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '今日の整理',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/record/create');
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('思い出を保存'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // 価値査定機能は将来実装
                },
                icon: const Icon(Icons.search),
                label: const Text('価値を調べる'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
