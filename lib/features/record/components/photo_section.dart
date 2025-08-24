import 'package:flutter/material.dart';

class PhotoSection extends StatelessWidget {
  final List<String> imagePaths;
  final VoidCallback onAddPhoto;

  const PhotoSection({
    super.key,
    required this.imagePaths,
    required this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text('写真: ${imagePaths.length}枚'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onAddPhoto,
          child: const Text('写真追加'),
        ),
      ],
    );
  }
}