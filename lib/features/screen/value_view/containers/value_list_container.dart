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
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    setState(() => _isLoading = true);

    try {
      final totalCount = await ValueSearchRepository.count();
      final offset = (_currentPage - 1) * _itemsPerPage;
      final values = await ValueSearchRepository.findWithPagination(
        offset: offset,
        limit: _itemsPerPage,
      );

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

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _loadValues();
  }

  int get _totalPages => (_totalCount / _itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return ValueListPage(
      values: _values,
      isLoading: _isLoading,
      totalCount: _totalCount,
      currentPage: _currentPage,
      totalPages: _totalPages,
      onRefresh: _loadValues,
      onValueUpdated: _onValueUpdated,
      onPageChanged: _onPageChanged,
    );
  }
}
