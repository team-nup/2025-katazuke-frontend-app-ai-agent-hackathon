import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class PhotoSection extends StatelessWidget {
  final List<String> imagePaths;
  final VoidCallback onAddPhoto;
  final VoidCallback? onPickFromGallery;
  final Function(int)? onRemovePhoto;

  const PhotoSection({
    super.key,
    required this.imagePaths,
    required this.onAddPhoto,
    this.onPickFromGallery,
    this.onRemovePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text('写真: ${imagePaths.length}枚'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onAddPhoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('カメラ'),
              ),
            ),
            if (onPickFromGallery != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onPickFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('ギャラリー'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    foregroundColor: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (imagePaths.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildImageGrid(context),
        ],
      ],
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return GridView.builder(
      key: ValueKey(imagePaths.length),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return _buildImageItem(context, index);
      },
    );
  }

  Widget _buildImageItem(BuildContext context, int index) {
    final imagePath = imagePaths[index];

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(imagePath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
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
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
