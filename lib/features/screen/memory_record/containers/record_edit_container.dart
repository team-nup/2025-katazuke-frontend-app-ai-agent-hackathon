import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory.dart';
import '../../../../core/models/DB/memory_status.dart';
import '../pages/memory_record_edit_page.dart';
import '../utils/shared/image_picker_helper.dart';
import '../utils/shared/memory_service.dart';
import '../utils/shared/toast_helper.dart';

class RecordEditContainer extends StatefulWidget {
  final Memory memory;

  const RecordEditContainer({
    super.key,
    required this.memory,
  });

  @override
  State<RecordEditContainer> createState() => _RecordEditContainerState();
}

class _RecordEditContainerState extends State<RecordEditContainer> {
  // Form data using Memory type structure (initialized with existing data)
  late String _title;
  late String? _detail;
  late int? _startAge;
  late int? _endAge;
  late List<String> _imagePaths;
  late MemoryStatus _status;

  // 削除対象の画像パスを保持
  List<String> _imagesToDelete = [];

  // UI state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize form with existing memory data
    _title = widget.memory.title;
    _detail = widget.memory.detail;
    _startAge = widget.memory.startAge;
    _endAge = widget.memory.endAge;
    _imagePaths = List.from(widget.memory.imagePaths ?? []);
    _status = widget.memory.status;
  }

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

  Future<void> _updateMemory() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedMemory = await MemoryService.updateMemory(
        originalMemory: widget.memory,
        title: _title,
        detail: _detail,
        startAge: _startAge,
        endAge: _endAge,
        imagePaths: _imagePaths,
        imagesToDelete: _imagesToDelete,
        status: _status,
      );

      if (mounted) {
        ToastHelper.showUpdateSuccess(context);
        Navigator.of(context).pop(updatedMemory);
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

  void _onRemovePhoto(int index) {
    final imagePath = _imagePaths[index];
    setState(() {
      _imagePaths.removeAt(index);
      // 元の画像リストに含まれていた場合のみ削除対象に追加
      if (widget.memory.imagePaths?.contains(imagePath) == true) {
        _imagesToDelete.add(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecordEditPage(
      title: _title,
      detail: _detail,
      startAge: _startAge,
      endAge: _endAge,
      status: _status,
      imagePaths: _imagePaths,
      isLoading: _isLoading,
      onTitleChanged: (value) => setState(() => _title = value),
      onDetailChanged: (value) =>
          setState(() => _detail = value.isEmpty ? null : value),
      onStartAgeChanged: (value) =>
          setState(() => _startAge = int.tryParse(value)),
      onEndAgeChanged: (value) => setState(() => _endAge = int.tryParse(value)),
      onStatusChanged: (status) => setState(() => _status = status),
      onAddPhoto: _addPhoto,
      onPickFromGallery: _pickFromGallery,
      onRemovePhoto: _onRemovePhoto,
      onUpdate: _updateMemory,
    );
  }
}
