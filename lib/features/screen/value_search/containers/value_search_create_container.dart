import 'package:flutter/material.dart';
import 'dart:math';
import '../../../../core/models/DB/memory_status.dart';
import '../pages/value_search_create_page.dart';
import '../../memory_record/utils/shared/image_picker_helper.dart';
import '../utils/shared/value_search_service.dart';
import '../../memory_record/utils/shared/toast_helper.dart';

class ValueSearchCreateContainer extends StatefulWidget {
  const ValueSearchCreateContainer({super.key});

  @override
  State<ValueSearchCreateContainer> createState() =>
      _ValueSearchCreateContainerState();
}

class _ValueSearchCreateContainerState
    extends State<ValueSearchCreateContainer> {
  // Form data using ValueSearch type structure
  String _title = '';
  String? _detail;
  List<String> _imagePaths = [];
  ItemKeepStatus _status = ItemKeepStatus.keeping;

  // UI state
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _addPhoto() async {
    await ImagePickerHelper.addPhotoFromCamera(
      context: context,
      imagePaths: _imagePaths,
      onUpdate: () => setState(() {}),
    );
  }

  Future<void> _pickFromGallery() async {
    await ImagePickerHelper.pickFromGallery(
      context: context,
      imagePaths: _imagePaths,
      onUpdate: () => setState(() {}),
    );
  }

  Future<void> _saveValueSearch() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Generate dummy AI values
      final random = Random();
      final dummyValue = random.nextInt(50000) + 1000; // 1000-51000
      final dummyProductName = _generateDummyProductName();
      final dummyConfidence = random.nextInt(40) + 60; // 60-100
      final dummyMinPrice = (dummyValue * 0.8).round();
      final dummyMaxPrice = (dummyValue * 1.2).round();

      await ValueSearchService.createValueSearch(
        title: _title,
        detail: _detail,
        imagePaths: _imagePaths,
        value: dummyValue,
        status: _status,
        detectedProductName: dummyProductName,
        aiConfidenceScore: dummyConfidence,
        minPrice: dummyMinPrice,
        maxPrice: dummyMaxPrice,
      );

      if (mounted) {
        ToastHelper.showCreateSuccess(context);
        _resetForm();
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(
            context, e.toString().replaceFirst('Exception: ', ''));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _generateDummyProductName() {
    final products = [
      'ヴィンテージ腕時計',
      'レトロカメラ',
      'アンティーク花瓶',
      'ブランドバッグ',
      'コレクション本',
      'ゲーム機',
      'フィギュア',
      'ジュエリー',
      '絵画',
      '楽器',
    ];
    final random = Random();
    return products[random.nextInt(products.length)];
  }

  void _resetForm() {
    setState(() {
      _title = '';
      _detail = null;
      _imagePaths.clear();
      _status = ItemKeepStatus.keeping;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueSearchCreatePage(
      title: _title,
      detail: _detail,
      status: _status,
      imagePaths: _imagePaths,
      isLoading: _isLoading,
      onTitleChanged: (value) => setState(() => _title = value),
      onDetailChanged: (value) =>
          setState(() => _detail = value.isEmpty ? null : value),
      onStatusChanged: (status) => setState(() => _status = status),
      onAddPhoto: _addPhoto,
      onPickFromGallery: _pickFromGallery,
      onRemovePhoto: (index) => setState(() => _imagePaths.removeAt(index)),
      onSave: _saveValueSearch,
    );
  }
}
