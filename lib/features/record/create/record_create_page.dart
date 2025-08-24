import 'package:flutter/material.dart';
import '../../../core/models/shared/memory_status.dart';
import '../../../core/database/repositories/memory_repository.dart';
import '../components/memory_form.dart';
import '../components/photo_section.dart';
import '../utils/memory_validator.dart';
import '../utils/image_picker_helper.dart';
import 'utils/memory_factory.dart';

class RecordCreatePage extends StatefulWidget {
  const RecordCreatePage({super.key});

  @override
  State<RecordCreatePage> createState() => _RecordCreatePageState();
}

class _RecordCreatePageState extends State<RecordCreatePage> {
  // Form data using Memory type structure
  String _title = '';
  String? _detail;
  int? _startAge;
  int? _endAge;
  List<String> _imagePaths = [];
  MemoryStatus _status = MemoryStatus.disposed;

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

    // Validation
    final validationError = MemoryValidator.validateAll(
      title: _title,
      detail: _detail,
      startAge: _startAge,
      endAge: _endAge,
    );

    if (validationError != null) {
      _showErrorToast(validationError);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create Memory using factory
      final memory = MemoryFactory.createFromForm(
        title: _title,
        detail: _detail,
        startAge: _startAge,
        endAge: _endAge,
        imagePaths: _imagePaths,
        status: _status,
      );

      // Save to database
      await MemoryRepository.insert(memory);

      // Show success message
      _showSuccessToast();

      // Reset form
      _resetForm();
    } catch (e) {
      _showErrorToast('保存エラー: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('エラー: $message')),
    );
  }

  void _showSuccessToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('保存完了')),
    );
  }

  void _resetForm() {
    setState(() {
      _title = '';
      _detail = null;
      _startAge = null;
      _endAge = null;
      _imagePaths.clear();
      _status = MemoryStatus.disposed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('思い出を記録'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MemoryForm(
              title: _title,
              detail: _detail,
              startAge: _startAge,
              endAge: _endAge,
              status: _status,
              onTitleChanged: (value) => setState(() => _title = value),
              onDetailChanged: (value) =>
                  setState(() => _detail = value.isEmpty ? null : value),
              onStartAgeChanged: (value) =>
                  setState(() => _startAge = int.tryParse(value)),
              onEndAgeChanged: (value) =>
                  setState(() => _endAge = int.tryParse(value)),
              onStatusChanged: (status) => setState(() => _status = status),
            ),
            PhotoSection(
              imagePaths: _imagePaths,
              onAddPhoto: _addPhoto,
              onPickFromGallery: _pickFromGallery,
              onRemovePhoto: (index) {
                setState(() {
                  _imagePaths.removeAt(index);
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveMemory,
                child: _isLoading ? const Text('保存中...') : const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
