import 'package:flutter/material.dart';
import 'package:okataduke/core/database/repositories/memory_repository.dart';
import 'package:okataduke/core/models/DB/memory.dart';

class MemoryListState extends ChangeNotifier {
  List<Memory> _memories = [];
  bool _isLoading = true;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalCount = 0;
  static const int _itemsPerPage = 10;

  List<Memory> get memories => _memories;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalCount => _totalCount;

  Future<void> loadMemories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final totalCount = await MemoryRepository.count();
      final memories = await MemoryRepository.findAll(
        limit: _itemsPerPage,
        offset: (_currentPage - 1) * _itemsPerPage,
      );

      _memories = memories;
      _totalCount = totalCount;
      _totalPages = (_totalCount / _itemsPerPage).ceil();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= _totalPages && page != _currentPage) {
      _currentPage = page;
      loadMemories();
    }
  }
}
