import 'package:flutter/material.dart';
import '../../../services/native/camera_service.dart';

class ImagePickerHelper {
  static final CameraService _cameraService = CameraService();

  static Future<void> addPhotoFromCamera({
    required BuildContext context,
    required List<String> imagePaths,
    required VoidCallback onUpdate,
  }) async {
    try {
      final String? imagePath = await _cameraService.takePicture();
      if (imagePath != null) {
        imagePaths.add(imagePath);
        onUpdate();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('写真追加: ${imagePaths.length}枚')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラー: $e')),
      );
    }
  }

  static Future<void> pickFromGallery({
    required BuildContext context,
    required List<String> imagePaths,
    required VoidCallback onUpdate,
  }) async {
    try {
      final String? imagePath = await _cameraService.pickFromGallery();
      if (imagePath != null) {
        imagePaths.add(imagePath);
        onUpdate();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('写真追加: ${imagePaths.length}枚')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラー: $e')),
      );
    }
  }
}
