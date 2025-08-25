import 'package:flutter/material.dart';
import '../../../core/models/shared/memory.dart';
import '../components/shared/recent_memories_section.dart';

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
      appBar: AppBar(
        title: const Text('Memoria'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatisticsCard(context),
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
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    final totalMemories = statistics['total'] ?? 0;
    final disposedThisMonth = statistics['disposed'] ?? 0;

    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
            colors: [Colors.teal.shade400, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '思い出統計',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    '保存した思い出',
                    '$totalMemories件',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    '今月の整理',
                    '$disposedThisMonth件',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
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