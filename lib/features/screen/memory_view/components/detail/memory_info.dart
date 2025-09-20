import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/memory.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'memory_detail_card.dart';
import 'memory_usage_period.dart';
import 'memory_status_display.dart';

class MemoryInfo extends StatelessWidget {
  final Memory memory;

  const MemoryInfo({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.label,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                memory.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (memory.detail != null) ...[
          MemoryDetailCard(detail: memory.detail!),
          const SizedBox(height: 16),
        ],
        if (memory.startAge != null || memory.endAge != null) ...[
          MemoryUsagePeriod(memory: memory),
          const SizedBox(height: 16),
        ],
        MemoryStatusDisplay(memory: memory),
      ],
    );
  }
}
