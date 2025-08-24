import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/models/shared/memory.dart';
import '../../core/database/repositories/memory_repository.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({super.key});

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  List<Memory> _memories = [];
  bool _isLoading = true;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalCount = 0;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  Future<void> _loadMemories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final totalCount = await MemoryRepository.count();
      final memories = await MemoryRepository.findAll(
        limit: _itemsPerPage,
        offset: (_currentPage - 1) * _itemsPerPage,
      );

      setState(() {
        _memories = memories;
        _totalCount = totalCount;
        _totalPages = (_totalCount / _itemsPerPage).ceil();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('データ読み込みエラー: $e')),
      );
    }
  }

  void _goToPage(int page) {
    if (page >= 1 && page <= _totalPages && page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
      _loadMemories();
    }
  }

  Widget _buildMemoryItem(Memory memory) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (memory.imagePaths != null && memory.imagePaths!.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: memory.imagePaths!.length,
                itemBuilder: (context, index) {
                  final imagePath = memory.imagePaths![index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.file(
                      File(imagePath),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memory.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (memory.detail != null) ...[
                  Text(
                    memory.detail!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                ],
                if (memory.startAge != null || memory.endAge != null) ...[
                  Text(
                    '年齢: ${memory.startAge ?? '?'}歳 - ${memory.endAge ?? '?'}歳',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  'ステータス: ${memory.status.name}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  '保存日: ${memory.insertedAt.year}/${memory.insertedAt.month}/${memory.insertedAt.day}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    if (_totalPages <= 1) return const SizedBox.shrink();

    List<Widget> pageButtons = [];

    // 前のページボタン
    pageButtons.add(
      IconButton(
        onPressed: _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
        icon: const Icon(Icons.chevron_left),
      ),
    );

    // ページ番号ボタン
    int startPage = (_currentPage - 2).clamp(1, _totalPages);
    int endPage = (_currentPage + 2).clamp(1, _totalPages);

    if (startPage > 1) {
      pageButtons.add(
        TextButton(
          onPressed: () => _goToPage(1),
          child: const Text('1'),
        ),
      );
      if (startPage > 2) {
        pageButtons.add(const Text('...'));
      }
    }

    for (int i = startPage; i <= endPage; i++) {
      pageButtons.add(
        TextButton(
          onPressed: () => _goToPage(i),
          style: TextButton.styleFrom(
            backgroundColor: i == _currentPage ? Colors.teal.shade100 : null,
          ),
          child: Text(
            '$i',
            style: TextStyle(
              fontWeight:
                  i == _currentPage ? FontWeight.bold : FontWeight.normal,
              color: i == _currentPage ? Colors.teal.shade700 : null,
            ),
          ),
        ),
      );
    }

    if (endPage < _totalPages) {
      if (endPage < _totalPages - 1) {
        pageButtons.add(const Text('...'));
      }
      pageButtons.add(
        TextButton(
          onPressed: () => _goToPage(_totalPages),
          child: Text('$_totalPages'),
        ),
      );
    }

    // 次のページボタン
    pageButtons.add(
      IconButton(
        onPressed: _currentPage < _totalPages
            ? () => _goToPage(_currentPage + 1)
            : null,
        icon: const Icon(Icons.chevron_right),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pageButtons,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('思い出 (${_totalCount}件)'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _memories.isEmpty
              ? const Center(
                  child: Text(
                    '保存された思い出がありません',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: _memories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _memories.length) {
                      return _buildPagination();
                    }
                    return _buildMemoryItem(_memories[index]);
                  },
                ),
    );
  }
}
