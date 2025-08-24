import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/shared/memory.dart';
import '../../core/models/shared/memory_status.dart';
import '../../core/database/repositories/memory_repository.dart';
import '../../native/camera_service.dart';
import 'logic/form/memory_validation.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  final _startAgeController = TextEditingController();
  final _endAgeController = TextEditingController();
  
  final CameraService _cameraService = CameraService();
  final List<String> _imagePaths = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _startAgeController.dispose();
    _endAgeController.dispose();
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

  Future<void> _saveMemory() async {
    if (_isLoading) return;

    // バリデーションチェック
    final titleError = MemoryValidation.validateTitle(_titleController.text);
    if (titleError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('バリデーションエラー: $titleError')),
      );
      return;
    }

    final detailError = MemoryValidation.validateDetail(_detailController.text);
    if (detailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('バリデーションエラー: $detailError')),
      );
      return;
    }

    final startAge = _startAgeController.text.isEmpty ? null : int.tryParse(_startAgeController.text);
    final endAge = _endAgeController.text.isEmpty ? null : int.tryParse(_endAgeController.text);
    final ageError = MemoryValidation.validateAges(startAge, endAge);
    if (ageError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('バリデーションエラー: $ageError')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final memory = Memory(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        detail: _detailController.text.isEmpty ? null : _detailController.text.trim(),
        startAge: startAge,
        endAge: endAge,
        imagePaths: _imagePaths.isEmpty ? null : _imagePaths,
        status: MemoryStatus.keeping,
        insertedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await MemoryRepository.insert(memory);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('保存完了')),
      );
      
      _titleController.clear();
      _detailController.clear();
      _startAgeController.clear();
      _endAgeController.clear();
      setState(() {
        _imagePaths.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存エラー: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記録'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'タイトル'),
          ),
          TextField(
            controller: _detailController,
            decoration: const InputDecoration(labelText: '詳細'),
          ),
          TextField(
            controller: _startAgeController,
            decoration: const InputDecoration(labelText: '開始年齢'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _endAgeController,
            decoration: const InputDecoration(labelText: '終了年齢'),
            keyboardType: TextInputType.number,
          ),
          Text('写真: ${_imagePaths.length}枚'),
          ElevatedButton(
            onPressed: _addPhoto,
            child: const Text('写真追加'),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _saveMemory,
            child: _isLoading ? const Text('保存中...') : const Text('保存'),
          ),
        ],
      ),
    );
  }
}
