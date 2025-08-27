import 'package:flutter/material.dart';
import '../../../../../core/models/DB/memory.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Memory memory;

  const DeleteConfirmationDialog({
    super.key,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('削除の確認'),
      content: Text('「${memory.title}」を削除しますか？\n\nこの操作は取り消せません。'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: const Text('削除'),
        ),
      ],
    );
  }

  static Future<bool?> show(BuildContext context, Memory memory) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(memory: memory),
    );
  }
}
