import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../components/shared/value_search_form.dart';
import '../../../components/app_bar.dart';

class ValueSearchCreatePage extends StatelessWidget {
  final String? detail;
  final ItemKeepStatus status;
  final List<String> imagePaths;
  final bool isLoading;

  // Callbacks
  final ValueChanged<String> onDetailChanged;
  final ValueChanged<ItemKeepStatus> onStatusChanged;
  final VoidCallback onAddPhoto;
  final VoidCallback onPickFromGallery;
  final ValueChanged<int> onRemovePhoto;
  final VoidCallback onSave;

  const ValueSearchCreatePage({
    super.key,
    this.detail,
    required this.status,
    required this.imagePaths,
    required this.isLoading,
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
      backgroundColor: AppColors.background,
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
              detail: detail,
              status: status,
              imagePaths: imagePaths,
              onDetailChanged: onDetailChanged,
              onStatusChanged: onStatusChanged,
              onAddPhoto: onAddPhoto,
              onPickFromGallery: onPickFromGallery,
              onRemovePhoto: onRemovePhoto,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.search,
                              size: 20, color: AppColors.iconGreen),
                          SizedBox(width: 8),
                          Text(
                            '価値を調べる',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
