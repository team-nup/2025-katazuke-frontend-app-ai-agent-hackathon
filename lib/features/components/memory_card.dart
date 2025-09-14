import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/core/models/DB/memory.dart';

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
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildImageSection(),
              const SizedBox(width: 12),
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
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryLight,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: (memory.imagePaths?.isNotEmpty ?? false)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(7),
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
      size: 28,
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          memory.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        if (showFullDetails &&
            memory.detail != null &&
            memory.detail!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              memory.detail!,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 14,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              _formatDate(memory.insertedAt),
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            if (memory.startAge != null && memory.endAge != null) ...[
              const SizedBox(width: 12),
              Icon(
                Icons.cake,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '${memory.startAge}-${memory.endAge}歳',
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return '今日';
    } else if (difference == 1) {
      return '昨日';
    } else if (difference < 7) {
      return '${difference}日前';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return '${weeks}週間前';
    } else if (difference < 365) {
      final months = (difference / 30).floor();
      return '${months}ヶ月前';
    } else {
      final years = (difference / 365).floor();
      return '${years}年前';
    }
  }
}
