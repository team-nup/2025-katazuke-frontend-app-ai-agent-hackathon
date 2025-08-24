import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class StorageService {
  static const String _okatadukeMemoriesDir = 'okataduke_memories';
  
  Future<String> saveImage(File imageFile) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String memoriesDirPath = path.join(appDir.path, _okatadukeMemoriesDir);
      final Directory memoriesDirectory = Directory(memoriesDirPath);
      
      if (!await memoriesDirectory.exists()) {
        await memoriesDirectory.create(recursive: true);
      }
      
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileName = 'memory_$timestamp.jpg';
      final String destinationPath = path.join(memoriesDirPath, fileName);
      
      final File savedFile = await imageFile.copy(destinationPath);
      debugPrint('Image saved: $destinationPath');
      
      return savedFile.path;
    } catch (e) {
      debugPrint('Error saving image: $e');
      rethrow;
    }
  }

  Future<bool> deleteImage(String imagePath) async {
    try {
      final File file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        debugPrint('Image deleted: $imagePath');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error deleting image: $e');
      return false;
    }
  }

  Future<bool> fileExists(String imagePath) async {
    try {
      final File file = File(imagePath);
      return await file.exists();
    } catch (e) {
      debugPrint('Error checking file existence: $e');
      return false;
    }
  }

  Future<void> cleanupOrphanedFiles(List<String> validPaths) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String memoriesDirPath = path.join(appDir.path, _okatadukeMemoriesDir);
      final Directory memoriesDirectory = Directory(memoriesDirPath);
      
      if (!await memoriesDirectory.exists()) {
        return;
      }
      
      final List<FileSystemEntity> files = await memoriesDirectory.list().toList();
      
      for (FileSystemEntity file in files) {
        if (file is File && !validPaths.contains(file.path)) {
          await file.delete();
          debugPrint('Orphaned file deleted: ${file.path}');
        }
      }
    } catch (e) {
      debugPrint('Error cleaning up orphaned files: $e');
    }
  }

  Future<String> getStorageDirectory() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    return path.join(appDir.path, _okatadukeMemoriesDir);
  }
}