import 'package:flutter/material.dart';
import 'dart:math';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:okataduke/features/screen/memory_record/utils/shared/image_picker_helper.dart';
import 'package:okataduke/features/screen/memory_record/utils/shared/toast_helper.dart';
import 'package:okataduke/features/screen/value_search/pages/value_search_create_page.dart';
import 'package:okataduke/features/screen/value_search/utils/shared/value_search_service.dart';
import 'package:okataduke/features/screen/value_search/utils/shared/product_analysis_service.dart';

class ValueSearchCreateContainer extends StatefulWidget {
  const ValueSearchCreateContainer({super.key});

  @override
  State<ValueSearchCreateContainer> createState() =>
      _ValueSearchCreateContainerState();
}

class _ValueSearchCreateContainerState
    extends State<ValueSearchCreateContainer> {
  String _title = '';
  String? _detail;
  List<String> _imagePaths = [];
  ItemKeepStatus _status = ItemKeepStatus.keeping;

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
      String dummyProductName;
      int dummyConfidence;

      if (_imagePaths.isNotEmpty) {
        final analysisResult = await ProductAnalysisService.analyzeProduct(
          imagePath: _imagePaths[0],
          userHint: _detail,
        );

        if (analysisResult.success) {
          dummyProductName = analysisResult.productName;
          dummyConfidence = analysisResult.confidence;
        } else {
          print('Product analysis error: ${analysisResult.error}');
          dummyProductName = _generateDummyProductName();
          dummyConfidence = Random().nextInt(40) + 60;
        }
      } else {
        dummyProductName = _generateDummyProductName();
        dummyConfidence = Random().nextInt(40) + 60;
      }

      final random = Random();
      final dummyValue = random.nextInt(50000) + 1000;
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
      print('Value search error: $e');
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
