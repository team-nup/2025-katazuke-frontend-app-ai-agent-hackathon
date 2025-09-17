import 'package:flutter/material.dart';
import 'package:okataduke/core/database/repositories/value_search_repository.dart';
import 'package:okataduke/core/database/repositories/candidate_product_name_repository.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'package:okataduke/core/models/DB/candidate_product_name.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import '../utils/detail/search_url_launcher.dart';

import '../pages/value_detail_page.dart';

class ValueDetailContainer extends StatefulWidget {
  final ValueSearch valueSearch;

  const ValueDetailContainer({
    super.key,
    required this.valueSearch,
  });

  @override
  State<ValueDetailContainer> createState() => _ValueDetailContainerState();
}

class _ValueDetailContainerState extends State<ValueDetailContainer> {
  late ValueSearch _currentValue;
  bool _hasBeenUpdated = false;
  List<CandidateProductName> _candidateNames = [];

  @override
  void initState() {
    super.initState();
    _currentValue = widget.valueSearch;
    _loadCandidateNames();
  }

  Future<void> _loadCandidateNames() async {
    try {
      final candidates =
          await CandidateProductNameRepository.findByValueSearchId(
              _currentValue.id);
      setState(() {
        _candidateNames = candidates;
      });
    } catch (e) {
      print('商品名候補の読み込みエラー: $e');
    }
  }

  Future<void> _navigateToEdit() async {
    // TODO: 編集画面への遷移を実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('編集機能は未実装です')),
    );
  }

  Future<void> _showDeleteConfirmDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('削除確認'),
        content:
            Text('「${_currentValue.detectedProductName ?? '不明な商品'}」を削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _deleteValue();
    }
  }

  Future<void> _deleteValue() async {
    try {
      await ValueSearchRepository.delete(_currentValue.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('価値分析を削除しました')),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('削除エラー: $e')),
        );
      }
    }
  }

  void _onStatusChanged(ItemKeepStatus status) {
    setState(() {
      _currentValue = _currentValue.copyWith(status: status);
    });
  }

  Future<void> _onSave(ItemKeepStatus status, int? price) async {
    try {
      final updatedValue = _currentValue.copyWith(
        status: status,
        value: price,
      );

      await ValueSearchRepository.update(updatedValue);

      setState(() {
        _currentValue = updatedValue;
        _hasBeenUpdated = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存しました')),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存エラー: $e')),
        );
      }
    }
  }

  void _onPopInvoked(bool didPop, dynamic result) {
    if (!didPop) {
      Navigator.of(context).pop(_hasBeenUpdated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueDetailPage(
      valueSearch: _currentValue,
      candidateNames: _candidateNames,
      onEdit: _navigateToEdit,
      onDelete: _showDeleteConfirmDialog,
      onPopInvoked: _onPopInvoked,
      onLaunchSearchUrl: (productName, platform) =>
          SearchUrlLauncher.launchSearchUrl(productName, platform, context),
      onStatusChanged: _onStatusChanged,
      onSave: _onSave,
    );
  }
}
