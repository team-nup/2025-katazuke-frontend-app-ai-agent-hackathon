import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../../../../core/models/DB/memory_status.dart';
import '../components/shared/memory_form.dart';
import '../../../components/app_bar.dart';

class RecordCreatePage extends StatelessWidget {
  final String title;
  final String? detail;
  final int? startAge;
  final int? endAge;
  final MemoryStatus status;
  final List<String> imagePaths;
  final bool isLoading;

  // Callbacks
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDetailChanged;
  final ValueChanged<String> onStartAgeChanged;
  final ValueChanged<String> onEndAgeChanged;
  final ValueChanged<MemoryStatus> onStatusChanged;
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
      backgroundColor: AppColors.background,
      appBar: const AppBarComponent(
        title: '思い出を記録',
        titleIcon: Icons.camera_alt,
        showBackButton: true,
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
              imagePaths: imagePaths,
              onTitleChanged: onTitleChanged,
              onDetailChanged: onDetailChanged,
              onStartAgeChanged: onStartAgeChanged,
              onEndAgeChanged: onEndAgeChanged,
              onStatusChanged: onStatusChanged,
              onAddPhoto: onAddPhoto,
              onPickFromGallery: onPickFromGallery,
              onRemovePhoto: onRemovePhoto,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 2,
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('保存中...'),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.save, size: 20),
                          SizedBox(width: 8),
                          Text('思い出を保存'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
