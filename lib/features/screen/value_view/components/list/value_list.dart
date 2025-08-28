import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'value_item.dart';

class ValueList extends StatelessWidget {
  final List<ValueSearch> values;
  final bool isLoading;
  final VoidCallback onRefresh;
  final VoidCallback onValueUpdated;

  const ValueList({
    super.key,
    required this.values,
    required this.isLoading,
    required this.onRefresh,
    required this.onValueUpdated,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (values.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '価値分析した品物がありません',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '品物を価値分析して記録してみましょう',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          return ValueItem(
            valueSearch: value,
            onTap: onValueUpdated,
          );
        },
      ),
    );
  }
}
