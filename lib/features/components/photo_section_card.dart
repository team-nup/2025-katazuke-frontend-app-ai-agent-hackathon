import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class PhotoSectionCard extends StatelessWidget {
  final String title;
  final List<String> imagePaths;
  final VoidCallback onAddPhoto;
  final VoidCallback? onPickFromGallery;
  final Function(int)? onRemovePhoto;

  const PhotoSectionCard({
    super.key,
    required this.title,
    required this.imagePaths,
    required this.onAddPhoto,
    this.onPickFromGallery,
    this.onRemovePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surface,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 写真表示エリア
            if (imagePaths.isEmpty) ...[
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.textDisabled.withOpacity(0.3),
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_camera_outlined,
                        size: 32,
                        color: AppColors.textDisabled,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '写真を追加してください',
                        style: TextStyle(
                          color: AppColors.textDisabled,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              _buildImageGrid(),
            ],

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildPhotoButton(
                    onPressed: onAddPhoto,
                    icon: Icons.camera_alt,
                    label: 'カメラ',
                  ),
                ),
                if (onPickFromGallery != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildPhotoButton(
                      onPressed: onPickFromGallery!,
                      icon: Icons.photo_library,
                      label: 'ギャラリー',
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.textDisabled.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppColors.iconGreen,
          size: 16,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shadowColor: const Color.fromARGB(255, 255, 211, 154),
          foregroundColor: const Color.fromARGB(255, 33, 33, 33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(color: AppColors.primary),
          elevation: 3,
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return _buildImageItem(index);
      },
    );
  }

  Widget _buildImageItem(int index) {
    final imagePath = imagePaths[index];

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Image.file(
              File(imagePath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.card,
                  child: Icon(
                    Icons.broken_image,
                    color: AppColors.textDisabled,
                    size: 24,
                  ),
                );
              },
            ),
          ),
        ),
        if (onRemovePhoto != null)
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: () async {
                try {
                  await onRemovePhoto!(index);
                } catch (e) {
                  debugPrint('Error in onRemovePhoto callback: $e');
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
