import 'package:flutter/material.dart';
import '../../../../../core/models/DB/memory_status.dart';
import 'basic_info_card.dart';
import 'age_card.dart';
import 'status_card.dart';

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
        BasicInfoCard(
          title: title,
          detail: detail,
          imagePaths: imagePaths,
          onTitleChanged: onTitleChanged,
          onDetailChanged: onDetailChanged,
          onAddPhoto: onAddPhoto,
          onPickFromGallery: onPickFromGallery,
          onRemovePhoto: onRemovePhoto,
        ),
        const SizedBox(height: 16),
        AgeCard(
          startAge: startAge,
          endAge: endAge,
          onStartAgeChanged: onStartAgeChanged,
          onEndAgeChanged: onEndAgeChanged,
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
