import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../../../../core/models/DB/memory.dart';
import '../components/shared/recent_memories_section.dart';
import '../components/shared/analytics_card.dart';
import '../components/shared/quick_actions_card.dart';
import '../../../components/app_bar.dart';

class HomePage extends StatelessWidget {
  final Map<String, int> statistics;
  final List<Memory> recentMemories;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(Memory) onMemoryTap;
  final VoidCallback? onNavigateToMemoryRecord;
  final VoidCallback? onNavigateToValueSearch;

  const HomePage({
    super.key,
    required this.statistics,
    required this.recentMemories,
    required this.isLoading,
    required this.onRefresh,
    required this.onMemoryTap,
    this.onNavigateToMemoryRecord,
    this.onNavigateToValueSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
            QuickActionsCard(
              onSaveMemory: onNavigateToMemoryRecord ?? () {},
              onCheckValue: onNavigateToValueSearch ?? () {},
              onRandomMemory: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('ランダム思い出機能は将来実装予定です'),
                  ),
                );
              },
            ),
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
}
