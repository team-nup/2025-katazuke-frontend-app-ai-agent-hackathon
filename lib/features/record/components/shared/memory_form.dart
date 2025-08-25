import 'package:flutter/material.dart';
import '../../../../core/models/shared/memory_status.dart';

class MemoryForm extends StatelessWidget {
  final String title;
  final String? detail;
  final int? startAge;
  final int? endAge;
  final MemoryStatus status;
  final Function(String) onTitleChanged;
  final Function(String) onDetailChanged;
  final Function(String) onStartAgeChanged;
  final Function(String) onEndAgeChanged;
  final Function(MemoryStatus) onStatusChanged;

  const MemoryForm({
    super.key,
    required this.title,
    this.detail,
    this.startAge,
    this.endAge,
    required this.status,
    required this.onTitleChanged,
    required this.onDetailChanged,
    required this.onStartAgeChanged,
    required this.onEndAgeChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: title,
          decoration: const InputDecoration(labelText: 'タイトル'),
          onChanged: onTitleChanged,
        ),
        TextFormField(
          initialValue: detail ?? '',
          decoration: const InputDecoration(labelText: '詳細'),
          onChanged: onDetailChanged,
        ),
        TextFormField(
          initialValue: startAge?.toString() ?? '',
          decoration: const InputDecoration(labelText: '開始年齢'),
          keyboardType: TextInputType.number,
          onChanged: onStartAgeChanged,
        ),
        TextFormField(
          initialValue: endAge?.toString() ?? '',
          decoration: const InputDecoration(labelText: '終了年齢'),
          keyboardType: TextInputType.number,
          onChanged: onEndAgeChanged,
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
        RadioListTile<MemoryStatus>(
          title: const Text('保管中'),
          subtitle: const Text('まだ手元にある思い出の品'),
          value: MemoryStatus.keeping,
          groupValue: status,
          onChanged: (MemoryStatus? value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
        ),
        RadioListTile<MemoryStatus>(
          title: const Text('検討中'),
          subtitle: const Text('処分を検討している思い出の品'),
          value: MemoryStatus.considering,
          groupValue: status,
          onChanged: (MemoryStatus? value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
        ),
        RadioListTile<MemoryStatus>(
          title: const Text('処分済み'),
          subtitle: const Text('既に手放した思い出の品（処分日を自動記録）'),
          value: MemoryStatus.disposed,
          groupValue: status,
          onChanged: (MemoryStatus? value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
        ),
      ],
    );
  }
}