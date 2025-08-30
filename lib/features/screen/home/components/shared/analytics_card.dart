import 'package:flutter/material.dart';

class AnalyticsCard extends StatelessWidget {
  final Map<String, int> statistics;

  const AnalyticsCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    final memoryDisposedCount = statistics['disposed'] ?? 0;
    final memoryKeepingCount = statistics['keeping'] ?? 0;
    final valueSearchConsideringCount =
        statistics['valueSearchConsidering'] ?? 0;
    final valueSearchDisposedCount = statistics['valueSearchDisposed'] ?? 0;

    return Card(
      elevation: 4,
      shadowColor: const Color(0xFFFF8F00).withValues(alpha: 0.2),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: const Color(0xFFFF8F00),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  '整理状況',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF212121),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 思い出セクション
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: const Color(0xFFE91E63),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '思い出',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF212121),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.inventory_2,
                    label: '保管中',
                    value: memoryKeepingCount,
                    color: const Color(0xFFFF9800),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.check_circle,
                    label: '処分済み',
                    value: memoryDisposedCount,
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 売却セクション
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  color: const Color(0xFFFF9800),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '売却',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF212121),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.psychology_alt,
                    label: '検討中',
                    value: valueSearchConsideringCount,
                    color: const Color(0xFFFF9800),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    icon: Icons.check_circle,
                    label: '処分済み',
                    value: valueSearchDisposedCount,
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int value,
    required Color color,
    bool isFullWidth = false,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: isFullWidth ? 32 : 24,
          ),
          const SizedBox(height: 6),
          Text(
            '$value',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: isFullWidth ? 28 : 24,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF212121),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}
