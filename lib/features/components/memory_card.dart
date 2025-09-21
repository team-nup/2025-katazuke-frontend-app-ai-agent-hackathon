import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/core/models/DB/memory.dart';
import '../screen/home/utils/age_range_formatter.dart';
import '../screen/home/utils/date_formatter.dart';

class MemoryCard extends StatelessWidget {
  final Memory memory;
  final VoidCallback? onTap;
  final bool showFullDetails;

  const MemoryCard({
    super.key,
    required this.memory,
    this.onTap,
    this.showFullDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              _buildImageSection(),
              const SizedBox(width: 16),
              Expanded(
                child: _buildContentSection(context),
              ),
              _buildStatusIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryLight,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: (memory.imagePaths?.isNotEmpty ?? false)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(memory.imagePaths!.first),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderIcon();
                },
              ),
            )
          : _buildPlaceholderIcon(),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Icon(
      Icons.photo,
      color: AppColors.primary,
      size: 36,
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          memory.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 14,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              DateFormatter.formatDate(memory.insertedAt),
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            if (memory.startAge != null || memory.endAge != null) ...[
              const SizedBox(width: 12),
              Icon(
                Icons.timeline,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                AgeRangeFormatter.formatAgeRange(
                    memory.startAge, memory.endAge),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    final isDisposed = memory.status.name == 'disposed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDisposed
            ? AppColors.success.withOpacity(0.1)
            : AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isDisposed ? Icons.check_circle : Icons.home,
            size: 14,
            color: isDisposed ? AppColors.success : AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            isDisposed ? '処分済み' : '保管中',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDisposed ? AppColors.success : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
