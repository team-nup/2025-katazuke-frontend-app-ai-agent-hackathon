import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory_status.dart';
import '../pages/memory_record_create_page.dart';
import '../utils/shared/image_picker_helper.dart';
import '../utils/shared/memory_service.dart';
import '../utils/shared/toast_helper.dart';

class RecordCreateContainer extends StatefulWidget {
  const RecordCreateContainer({super.key});

  @override
  State<RecordCreateContainer> createState() => _RecordCreateContainerState();
}

class _RecordCreateContainerState extends State<RecordCreateContainer> {
  // Form data using Memory type structure
  String _title = '';
  String? _detail;
  int? _startAge;
  int? _endAge;
  List<String> _imagePaths = [];
  ItemKeepStatus _status = ItemKeepStatus.disposed;

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

  Future<void> _saveMemory() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await MemoryService.createMemory(
        title: _title,
        detail: _detail,
        startAge: _startAge,
        endAge: _endAge,
        imagePaths: _imagePaths,
        status: _status,
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

  void _resetForm() {
    setState(() {
      _title = '';
      _detail = null;
      _startAge = null;
      _endAge = null;
      _imagePaths.clear();
      _status = ItemKeepStatus.disposed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecordCreatePage(
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
      onRemovePhoto: (index) => setState(() => _imagePaths.removeAt(index)),
      onSave: _saveMemory,
    );
  }
}
