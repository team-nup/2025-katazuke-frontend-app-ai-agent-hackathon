import 'package:flutter/material.dart';
import 'package:okataduke/core/database/repositories/value_search_repository.dart';
import 'package:okataduke/core/models/DB/value_search.dart';

import '../pages/value_list_page.dart';

class ValueListContainer extends StatefulWidget {
  const ValueListContainer({super.key});

  @override
  State<ValueListContainer> createState() => _ValueListContainerState();
}

class _ValueListContainerState extends State<ValueListContainer> {
  List<ValueSearch> _values = [];
  bool _isLoading = true;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    setState(() => _isLoading = true);

    try {
      final totalCount = await ValueSearchRepository.count();
      final values = await ValueSearchRepository.findAll();

      setState(() {
        _values = values;
        _totalCount = totalCount;
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

  void _onValueUpdated() {
    _loadValues();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListPage(
      values: _values,
      isLoading: _isLoading,
      totalCount: _totalCount,
      onRefresh: _loadValues,
      onValueUpdated: _onValueUpdated,
    );
  }
}
