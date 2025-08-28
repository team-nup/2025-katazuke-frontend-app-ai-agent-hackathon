import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'package:okataduke/features/screen/value_view/containers/value_detail_container.dart';

class ValueItem extends StatelessWidget {
  final ValueSearch valueSearch;
  final VoidCallback? onTap;

  const ValueItem({
    super.key,
    required this.valueSearch,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () async {
          final hasBeenUpdated = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (context) =>
                  ValueDetailContainer(valueSearch: valueSearch),
            ),
          );
          if (hasBeenUpdated == true) {
            onTap?.call();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: valueSearch.imagePaths.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(valueSearch.imagePaths.first),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey[400],
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.inventory,
                        size: 40,
                        color: Colors.grey[400],
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueSearch.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (valueSearch.detectedProductName != null) ...[
                      Text(
                        '商品名: ${valueSearch.detectedProductName}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.blue[700],
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (valueSearch.value != null) ...[
                      Text(
                        '推定価値: ¥${valueSearch.value!.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      _formatDate(valueSearch.insertedAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(valueSearch.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(valueSearch.status),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  Color _getStatusColor(dynamic status) {
    switch (status.toString()) {
      case 'ItemKeepStatus.keeping':
        return Colors.blue;
      case 'ItemKeepStatus.disposed':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  String _getStatusText(dynamic status) {
    switch (status.toString()) {
      case 'ItemKeepStatus.keeping':
        return '保管中';
      case 'ItemKeepStatus.disposed':
        return '処分済';
      default:
        return '保管中';
    }
  }
}
