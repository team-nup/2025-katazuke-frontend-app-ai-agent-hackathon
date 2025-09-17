import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/candidate_product_name.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class SearchUrlsSection extends StatelessWidget {
  final List<CandidateProductName> candidateNames;
  final void Function(String productName, String platform) onLaunchSearchUrl;

  const SearchUrlsSection({
    super.key,
    required this.candidateNames,
    required this.onLaunchSearchUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppColors.accentHeart.withOpacity(0.2),
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
            const Text(
              '値段検索用URL',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...candidateNames.map((candidate) =>
                _buildProductSearchButtons(candidate.productName)),
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
