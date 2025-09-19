import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:okataduke/features/screen/memory_record/utils/shared/image_picker_helper.dart';
import 'package:okataduke/features/screen/memory_record/utils/shared/toast_helper.dart';
import 'package:okataduke/features/screen/value_search/pages/value_search_create_page.dart';
import 'package:okataduke/features/screen/value_search/utils/shared/value_search_service.dart';
import 'package:okataduke/features/screen/value_search/utils/shared/product_analysis_service.dart';

class ValueSearchCreateContainer extends StatefulWidget {
  final VoidCallback? onSaved;

  const ValueSearchCreateContainer({
    super.key,
    this.onSaved,
  });

  @override
  State<ValueSearchCreateContainer> createState() =>
      _ValueSearchCreateContainerState();
}

class _ValueSearchCreateContainerState
    extends State<ValueSearchCreateContainer> {
  String? _detail;
  List<String> _imagePaths = [];
  ItemKeepStatus _status = ItemKeepStatus.considering;

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
      if (_imagePaths.isEmpty) {
        ToastHelper.showError(context, '画像を選択してください');
        return;
      }

      final analysisResult = await ProductAnalysisService.analyzeProduct(
        imagePath: _imagePaths[0],
        userHint: _detail,
      );

      if (!analysisResult.success) {
        ToastHelper.showError(context, 'AI分析に失敗しました: ${analysisResult.error}');
        return;
      }

      await ValueSearchService.createValueSearch(
        productNameHint: _detail,
        imagePaths: _imagePaths,
        value: null,
        status: _status,
        detectedProductName: analysisResult.productName,
        aiConfidenceScore: analysisResult.confidence,
        candidates: analysisResult.candidates,
      );

      if (mounted) {
        ToastHelper.showCreateSuccess(context);
        widget.onSaved?.call();
      }
    } catch (e) {
      print('Value search error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ValueSearchCreatePage(
      detail: _detail,
      status: _status,
      imagePaths: _imagePaths,
      isLoading: _isLoading,
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
