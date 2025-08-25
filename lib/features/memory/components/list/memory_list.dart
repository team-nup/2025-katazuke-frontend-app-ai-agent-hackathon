import 'package:flutter/material.dart';
import 'package:okataduke/core/models/shared/memory.dart';
import 'memory_item.dart';
import 'pagination.dart';

class MemoryList extends StatefulWidget {
  final List<Memory> memories;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final VoidCallback? onMemoryUpdated;

  const MemoryList({
    super.key,
    required this.memories,
    required this.isLoading,
    this.onRefresh,
    this.onMemoryUpdated,
  });

  @override
  State<MemoryList> createState() => _MemoryListState();
}

class _MemoryListState extends State<MemoryList> {
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  int get _totalPages => widget.memories.isEmpty
      ? 1
      : (widget.memories.length / _itemsPerPage).ceil();

  List<Memory> get _currentPageMemories {
    if (widget.memories.isEmpty) return [];

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return widget.memories.sublist(
      startIndex,
      endIndex > widget.memories.length ? widget.memories.length : endIndex,
    );
  }

  void _onPageChanged(int page) {
    if (page >= 1 && page <= _totalPages && page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.memories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '保存された思い出がありません',
              style: TextStyle(fontSize: 16),
            ),
            if (widget.onRefresh != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: widget.onRefresh,
                child: const Text('再読み込み'),
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _currentPageMemories.length + 1,
      itemBuilder: (context, index) {
        if (index == _currentPageMemories.length) {
          return Pagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPageChanged: _onPageChanged,
          );
        }
        return MemoryItem(
          memory: _currentPageMemories[index],
          onTap: widget.onMemoryUpdated,
        );
      },
    );
  }
}
