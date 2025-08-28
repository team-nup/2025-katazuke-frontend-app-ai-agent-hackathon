import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import '../components/list/value_list.dart';

class ValueListPage extends StatelessWidget {
  final List<ValueSearch> values;
  final bool isLoading;
  final int totalCount;
  final VoidCallback onRefresh;
  final VoidCallback onValueUpdated;

  const ValueListPage({
    super.key,
    required this.values,
    required this.isLoading,
    required this.totalCount,
    required this.onRefresh,
    required this.onValueUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('価値分析 ($totalCount)'),
        backgroundColor: Colors.orange.shade50,
      ),
      body: ValueList(
        values: values,
        isLoading: isLoading,
        onRefresh: onRefresh,
        onValueUpdated: onValueUpdated,
      ),
    );
  }
}
