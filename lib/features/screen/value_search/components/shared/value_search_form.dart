import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/features/components/photo_section_card.dart';
import 'product_hint_card.dart';
import 'value_status_card.dart';

class ValueSearchForm extends StatelessWidget {
  final String? detail;
  final ItemKeepStatus status;
  final List<String> imagePaths;
  final Function(String) onDetailChanged;
  final Function(ItemKeepStatus) onStatusChanged;
  final VoidCallback onAddPhoto;
  final VoidCallback? onPickFromGallery;
  final Function(int)? onRemovePhoto;

  const ValueSearchForm({
    super.key,
    this.detail,
    required this.status,
    required this.imagePaths,
    required this.onDetailChanged,
    required this.onStatusChanged,
    required this.onAddPhoto,
    this.onPickFromGallery,
    this.onRemovePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhotoSectionCard(
          title: 'どんな商品？',
          imagePaths: imagePaths,
          onAddPhoto: onAddPhoto,
          onPickFromGallery: onPickFromGallery,
          onRemovePhoto: onRemovePhoto,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          alignment: Alignment.center,
          child: Icon(
            Icons.keyboard_arrow_down,
            size: 32,
            color: AppColors.primary.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        ProductHintCard(
          detail: detail,
          onDetailChanged: onDetailChanged,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          alignment: Alignment.center,
          child: Icon(
            Icons.keyboard_arrow_down,
            size: 32,
            color: AppColors.primary.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        ValueStatusCard(
          status: status,
          onStatusChanged: onStatusChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
