import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import '../components/detail/value_info.dart';
import '../components/detail/value_images.dart';
import '../../../components/app_bar.dart';

class ValueDetailPage extends StatelessWidget {
  final ValueSearch valueSearch;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final void Function(bool, dynamic) onPopInvoked;

  const ValueDetailPage({
    super.key,
    required this.valueSearch,
    required this.onEdit,
    required this.onDelete,
    required this.onPopInvoked,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: onPopInvoked,
      child: Scaffold(
        appBar: AppBarComponent(
          title: '価値詳細',
          titleIcon: Icons.info,
          showBackButton: true,
          actions: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
              tooltip: '編集',
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              tooltip: '削除',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueInfo(valueSearch: valueSearch),
              if (valueSearch.imagePaths.isNotEmpty) ...[
                const SizedBox(height: 16),
                ValueImages(imagePaths: valueSearch.imagePaths),
              ],
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onEdit,
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
