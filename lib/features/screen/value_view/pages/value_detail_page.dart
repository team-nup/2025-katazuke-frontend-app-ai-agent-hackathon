import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'package:okataduke/core/models/DB/candidate_product_name.dart';
import '../components/detail/value_info.dart';
import '../components/detail/value_images.dart';
import '../../../components/app_bar.dart';

class ValueDetailPage extends StatelessWidget {
  final ValueSearch valueSearch;
  final List<CandidateProductName> candidateNames;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final void Function(bool, dynamic) onPopInvoked;
  final void Function(String productName, String platform) onLaunchSearchUrl;

  const ValueDetailPage({
    super.key,
    required this.valueSearch,
    required this.candidateNames,
    required this.onEdit,
    required this.onDelete,
    required this.onPopInvoked,
    required this.onLaunchSearchUrl,
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
              if (candidateNames.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSearchUrlsSection(),
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

  Widget _buildSearchUrlsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'テスト: 検索URL',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...candidateNames.map((candidate) => _buildProductSearchButtons(candidate.productName)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSearchButtons(String productName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => onLaunchSearchUrl(productName, 'mercari'),
                  icon: const Icon(Icons.search, size: 16),
                  label: const Text('メルカリ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red[700],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => onLaunchSearchUrl(productName, 'yahoo'),
                  icon: const Icon(Icons.search, size: 16),
                  label: const Text('ヤフオク'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[50],
                    foregroundColor: Colors.purple[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
