import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';

class ValueInfo extends StatelessWidget {
  final ValueSearch valueSearch;

  const ValueInfo({
    super.key,
    required this.valueSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valueSearch.detectedProductName ?? '不明な商品',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            if (valueSearch.productNameHint != null) ...[
              _buildInfoRow('商品名ヒント', valueSearch.productNameHint!),
              const SizedBox(height: 8),
            ],
            if (valueSearch.detectedProductName != null) ...[
              _buildInfoRow('商品名', valueSearch.detectedProductName!),
              const SizedBox(height: 8),
            ],
            if (valueSearch.value != null) ...[
              _buildInfoRow(
                '推定価値',
                '¥${valueSearch.value!.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                valueColor: Colors.green[700],
              ),
              const SizedBox(height: 8),
            ],
            if (valueSearch.aiConfidenceScore != null) ...[
              _buildInfoRow('AI信頼度', '${valueSearch.aiConfidenceScore}%'),
              const SizedBox(height: 8),
            ],
            _buildInfoRow('ステータス', _getStatusText(valueSearch.status)),
            const SizedBox(height: 8),
            if (valueSearch.disposedAt != null) ...[
              _buildInfoRow('処分日時', _formatDate(valueSearch.disposedAt!)),
              const SizedBox(height: 8),
            ],
            _buildInfoRow('登録日時', _formatDate(valueSearch.insertedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: valueColor != null ? FontWeight.bold : null,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
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
