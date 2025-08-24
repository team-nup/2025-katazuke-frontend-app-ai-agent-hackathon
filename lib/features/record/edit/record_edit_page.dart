import 'package:flutter/material.dart';
import '../../../core/models/shared/memory.dart';
import '../../../core/models/shared/memory_status.dart';
import '../../../core/database/repositories/memory_repository.dart';
import '../../../native/camera_service.dart';
import '../components/memory_form.dart';
import '../components/photo_section.dart';
import '../utils/memory_validator.dart';

class RecordEditPage extends StatefulWidget {
  final Memory memory;
  
  const RecordEditPage({
    super.key,
    required this.memory,
  });

  @override
  State<RecordEditPage> createState() => _RecordEditPageState();
}

class _RecordEditPageState extends State<RecordEditPage> {
  // Form data using Memory type structure (initialized with existing data)
  late String _title;
  late String? _detail;
  late int? _startAge;
  late int? _endAge;
  late List<String> _imagePaths;
  late MemoryStatus _status;
  
  // UI state
  final CameraService _cameraService = CameraService();
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
    try {
      final String? imagePath = await _cameraService.takePicture();
      if (imagePath != null) {
        setState(() {
          _imagePaths.add(imagePath);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('写真追加: ${_imagePaths.length}枚')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラー: $e')),
      );
    }
  }

  Future<void> _updateMemory() async {
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
      // Update Memory using copyWith
      final updatedMemory = widget.memory.copyWith(
        title: _title.trim(),
        detail: _detail?.isEmpty == true ? null : _detail?.trim(),
        startAge: _startAge,
        endAge: _endAge,
        imagePaths: _imagePaths.isEmpty ? null : _imagePaths,
        status: _status,
        disposedAt: _status == MemoryStatus.disposed 
            ? (widget.memory.disposedAt ?? DateTime.now()) 
            : (_status != MemoryStatus.disposed ? null : widget.memory.disposedAt),
        updatedAt: DateTime.now(),
      );

      // Save to database
      await MemoryRepository.update(updatedMemory);

      // Show success message
      _showSuccessToast();
      
      // Navigate back
      if (mounted) {
        Navigator.of(context).pop(updatedMemory);
      }
    } catch (e) {
      _showErrorToast('更新エラー: $e');
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
      const SnackBar(content: Text('更新完了')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('思い出を編集'),
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
                onPressed: _isLoading ? null : _updateMemory,
                child: _isLoading ? const Text('更新中...') : const Text('更新'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}