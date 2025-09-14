import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class BasicInfoCard extends StatelessWidget {
  final String title;
  final String? detail;
  final Function(String) onTitleChanged;
  final Function(String) onDetailChanged;
  final List<String> imagePaths;
  final VoidCallback onAddPhoto;
  final VoidCallback? onPickFromGallery;
  final Function(int)? onRemovePhoto;

  const BasicInfoCard({
    super.key,
    required this.title,
    this.detail,
    required this.onTitleChanged,
    required this.onDetailChanged,
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
                  Icons.edit,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'どんな思い出？',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStyledTextField(
              initialValue: title,
              labelText: 'タイトル',
              hintText: '例：小学生の時のランドセル',
              icon: Icons.title,
              onChanged: onTitleChanged,
            ),
            const SizedBox(height: 16),
            _buildStyledTextField(
              initialValue: detail ?? '',
              labelText: '詳細・思い出',
              hintText: 'この品物にまつわる思い出やエピソードを書いてください',
              icon: Icons.description,
              maxLines: 3,
              onChanged: onDetailChanged,
            ),
            const SizedBox(height: 24),
            Divider(
              color: AppColors.textDisabled.withOpacity(0.3),
              thickness: 1,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.photo_camera,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '写真を追加',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${imagePaths.length}枚',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
            if (imagePaths.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildImageGrid(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required String initialValue,
    required String labelText,
    required String hintText,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.card.withOpacity(0.5),
        border: Border.all(
          color: AppColors.textDisabled.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            color: AppColors.textDisabled,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.textSecondary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
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
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: AppColors.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
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
