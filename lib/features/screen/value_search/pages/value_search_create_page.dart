import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import '../components/shared/value_search_form.dart';
import '../../../components/photo_section.dart';
import '../../../components/app_bar.dart';

class ValueSearchCreatePage extends StatelessWidget {
  final String title;
  final String? detail;
  final ItemKeepStatus status;
  final List<String> imagePaths;
  final bool isLoading;

  // Callbacks
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDetailChanged;
  final ValueChanged<ItemKeepStatus> onStatusChanged;
  final VoidCallback onAddPhoto;
  final VoidCallback onPickFromGallery;
  final ValueChanged<int> onRemovePhoto;
  final VoidCallback onSave;

  const ValueSearchCreatePage({
    super.key,
    required this.title,
    this.detail,
    required this.status,
    required this.imagePaths,
    required this.isLoading,
    required this.onTitleChanged,
    required this.onDetailChanged,
    required this.onStatusChanged,
    required this.onAddPhoto,
    required this.onPickFromGallery,
    required this.onRemovePhoto,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        title: '価値を調べる',
        titleIcon: Icons.search,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueSearchForm(
              title: title,
              detail: detail,
              status: status,
              onTitleChanged: onTitleChanged,
              onDetailChanged: onDetailChanged,
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
                child: isLoading ? const Text('分析中...') : const Text('価値を分析'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
