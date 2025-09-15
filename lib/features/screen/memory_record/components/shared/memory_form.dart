import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory_status.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/features/screen/memory_record/components/shared/basic_info_card.dart';
import 'package:okataduke/features/screen/memory_record/components/shared/age_card.dart';
import 'package:okataduke/features/screen/memory_record/components/shared/status_card.dart';
import 'package:okataduke/features/components/photo_section_card.dart';

class MemoryForm extends StatelessWidget {
  final String title;
  final String? detail;
  final int? startAge;
  final int? endAge;
  final MemoryStatus status;
  final List<String> imagePaths;
  final Function(String) onTitleChanged;
  final Function(String) onDetailChanged;
  final Function(String) onStartAgeChanged;
  final Function(String) onEndAgeChanged;
  final Function(MemoryStatus) onStatusChanged;
  final VoidCallback onAddPhoto;
  final VoidCallback? onPickFromGallery;
  final Function(int)? onRemovePhoto;

  const MemoryForm({
    super.key,
    required this.title,
    this.detail,
    this.startAge,
    this.endAge,
    required this.status,
    required this.imagePaths,
    required this.onTitleChanged,
    required this.onDetailChanged,
    required this.onStartAgeChanged,
    required this.onEndAgeChanged,
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
          title: '写真で思い出を残す？',
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
        BasicInfoCard(
          title: title,
          detail: detail,
          onTitleChanged: onTitleChanged,
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
        AgeCard(
          startAge: startAge,
          endAge: endAge,
          onStartAgeChanged: onStartAgeChanged,
          onEndAgeChanged: onEndAgeChanged,
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
        StatusCard(
          status: status,
          onStatusChanged: onStatusChanged,
        ),
      ],
    );
  }
}
