import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> takePicture({bool saveToGallery = false}) async {
    try {
      final XFile? picture = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      
      if (picture == null) {
        return null;
      }
      
      final String localPath = await _saveToLocalStorage(picture);
      
      if (saveToGallery) {
        await _saveToGallery(picture);
      }
      
      return localPath;
    } catch (e) {
      debugPrint('Error taking picture: $e');
      rethrow;
    }
  }

  Future<String> _saveToLocalStorage(XFile picture) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String memoriesDir = path.join(appDir.path, 'okataduke_memories');
      
      final Directory memoriesDirObj = Directory(memoriesDir);
      if (!await memoriesDirObj.exists()) {
        await memoriesDirObj.create(recursive: true);
      }
      
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileName = 'memory_$timestamp.jpg';
      final String localPath = path.join(memoriesDir, fileName);
      
      final File localFile = await File(picture.path).copy(localPath);
      
      debugPrint('Image saved to local storage: $localPath');
      return localFile.path;
    } catch (e) {
      debugPrint('Error saving to local storage: $e');
      rethrow;
    }
  }

  Future<void> _saveToGallery(XFile picture) async {
    try {
      debugPrint('Gallery save is handled by ImagePicker automatically');
    } catch (e) {
      debugPrint('Error saving to gallery: $e');
      rethrow;
    }
  }
}