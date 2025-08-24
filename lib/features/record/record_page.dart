import 'package:flutter/material.dart';
import '../../../native/camera_service.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final CameraService _cameraService = CameraService();
  bool _isLoading = false;

  Future<void> _takePicture({required bool saveToGallery}) async {
    if (_isLoading) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final String? imagePath = await _cameraService.takePicture(
        saveToGallery: saveToGallery,
      );

      setState(() {
        _isLoading = false;
      });

      if (imagePath != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('画像を保存しました: $imagePath')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラー: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記録'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '記録（仮）',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: !_isLoading ? () => _takePicture(saveToGallery: false) : null,
              child: _isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('撮影（アプリ内のみ保存）'),
            ),
            ElevatedButton(
              onPressed: !_isLoading ? () => _takePicture(saveToGallery: true) : null,
              child: _isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('撮影（ギャラリーにも保存）'),
            ),
          ],
        ),
      ),
    );
  }
}
