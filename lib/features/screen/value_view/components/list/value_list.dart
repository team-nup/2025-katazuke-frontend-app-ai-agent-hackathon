import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'value_item.dart';
import '../../../memory_view/components/list/pagination.dart';

class ValueList extends StatelessWidget {
  final List<ValueSearch> values;
  final bool isLoading;
  final int currentPage;
  final int totalPages;
  final VoidCallback onRefresh;
  final VoidCallback onValueUpdated;
  final Function(int) onPageChanged;

  const ValueList({
    super.key,
    required this.values,
    required this.isLoading,
    required this.currentPage,
    required this.totalPages,
    required this.onRefresh,
    required this.onValueUpdated,
    required this.onPageChanged,
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

    return ListView.builder(
      itemCount: values.length + 1,
      itemBuilder: (context, index) {
        if (index == values.length) {
          return Pagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: onPageChanged,
          );
        }
        final value = values[index];
        return ValueItem(
          valueSearch: value,
          onTap: onValueUpdated,
        );
      },
    );
  }
}
