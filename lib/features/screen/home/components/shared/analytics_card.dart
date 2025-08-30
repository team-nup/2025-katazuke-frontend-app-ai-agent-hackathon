import 'package:flutter/material.dart';
import '../../../../../core/models/DB/memory_status.dart';
import '../../../../../core/mappers/memory_status_mapper.dart';

class AnalyticsCard extends StatelessWidget {
  final Map<String, int> statistics;

  const AnalyticsCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    final disposedCount = statistics['disposed'] ?? 0;
    final keepingCount = statistics['keeping'] ?? 0;

    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '統計',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        context,
                        '思い出${MemoryStatusMapper.toDisplayString(ItemKeepStatus.disposed)}',
                        '$disposedCount件',
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        context,
                        '思い出${MemoryStatusMapper.toDisplayString(ItemKeepStatus.keeping)}',
                        '$keepingCount件',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        context,
                        '売却${MemoryStatusMapper.toDisplayString(ItemKeepStatus.considering)}',
                        '${statistics['valueSearch'] ?? 0}件',
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
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
                color: const Color(0xFF212121),
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF757575),
              ),
        ),
      ],
    );
  }
}
