import 'package:flutter/material.dart';
import '../../../../core/models/DB/memory_status.dart';
import '../components/shared/memory_form.dart';
import '../components/shared/photo_section.dart';

class RecordCreatePage extends StatelessWidget {
  final String title;
  final String? detail;
  final int? startAge;
  final int? endAge;
  final ItemKeepStatus status;
  final List<String> imagePaths;
  final bool isLoading;

  // Callbacks
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDetailChanged;
  final ValueChanged<String> onStartAgeChanged;
  final ValueChanged<String> onEndAgeChanged;
  final ValueChanged<ItemKeepStatus> onStatusChanged;
  final VoidCallback onAddPhoto;
  final VoidCallback onPickFromGallery;
  final ValueChanged<int> onRemovePhoto;
  final VoidCallback onSave;

  const RecordCreatePage({
    super.key,
    required this.title,
    this.detail,
    this.startAge,
    this.endAge,
    required this.status,
    required this.imagePaths,
    required this.isLoading,
    required this.onTitleChanged,
    required this.onDetailChanged,
    required this.onStartAgeChanged,
    required this.onEndAgeChanged,
    required this.onStatusChanged,
    required this.onAddPhoto,
    required this.onPickFromGallery,
    required this.onRemovePhoto,
    required this.onSave,
  });

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
              title: title,
              detail: detail,
              startAge: startAge,
              endAge: endAge,
              status: status,
              onTitleChanged: onTitleChanged,
              onDetailChanged: onDetailChanged,
              onStartAgeChanged: onStartAgeChanged,
              onEndAgeChanged: onEndAgeChanged,
              onStatusChanged: onStatusChanged,
            ),
            PhotoSection(
              imagePaths: imagePaths,
              onAddPhoto: onAddPhoto,
              onPickFromGallery: onPickFromGallery,
              onRemovePhoto: onRemovePhoto,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSave,
                child: isLoading ? const Text('保存中...') : const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
