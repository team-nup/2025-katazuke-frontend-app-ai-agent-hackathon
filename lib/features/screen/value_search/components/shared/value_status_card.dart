import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';

class ValueStatusCard extends StatelessWidget {
  final ItemKeepStatus status;
  final Function(ItemKeepStatus) onStatusChanged;

  const ValueStatusCard({
    super.key,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppColors.primary.withOpacity(0.2),
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
                  Icons.inventory_2,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'アイテムのステータス',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                RadioListTile<ItemKeepStatus>(
                  title: const Text('検討中'),
                  subtitle: const Text('処分を検討しているアイテム'),
                  value: ItemKeepStatus.considering,
                  groupValue: status,
                  activeColor: AppColors.primary,
                  onChanged: (ItemKeepStatus? value) {
                    if (value != null) {
                      onStatusChanged(value);
                    }
                  },
                ),
                RadioListTile<ItemKeepStatus>(
                  title: const Text('処分済み'),
                  subtitle: const Text('既に手放したアイテム（処分日を自動記録）'),
                  value: ItemKeepStatus.disposed,
                  groupValue: status,
                  activeColor: AppColors.primary,
                  onChanged: (ItemKeepStatus? value) {
                    if (value != null) {
                      onStatusChanged(value);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}