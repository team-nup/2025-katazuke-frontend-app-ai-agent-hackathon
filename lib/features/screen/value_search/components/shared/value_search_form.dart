import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';

class ValueSearchForm extends StatelessWidget {
  final String? detail;
  final ItemKeepStatus status;
  final Function(String) onDetailChanged;
  final Function(ItemKeepStatus) onStatusChanged;

  const ValueSearchForm({
    super.key,
    this.detail,
    required this.status,
    required this.onDetailChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: detail ?? '',
          decoration: const InputDecoration(labelText: '商品名のヒント・詳細'),
          onChanged: onDetailChanged,
        ),
        const SizedBox(height: 16),
        Text(
          'ステータス',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        _buildStatusRadios(),
      ],
    );
  }

  Widget _buildStatusRadios() {
    return Column(
      children: [
        RadioListTile<ItemKeepStatus>(
          title: const Text('保管中'),
          subtitle: const Text('まだ手元にあるアイテム'),
          value: ItemKeepStatus.keeping,
          groupValue: status,
          onChanged: (ItemKeepStatus? value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
        ),
        RadioListTile<ItemKeepStatus>(
          title: const Text('検討中'),
          subtitle: const Text('処分を検討しているアイテム'),
          value: ItemKeepStatus.considering,
          groupValue: status,
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
          onChanged: (ItemKeepStatus? value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
        ),
      ],
    );
  }
}
