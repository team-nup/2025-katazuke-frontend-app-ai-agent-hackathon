import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'package:okataduke/core/models/DB/candidate_product_name.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../components/detail/value_info.dart';
import '../components/detail/value_images.dart';
import '../components/detail/search_urls_section.dart';
import '../../../components/app_bar.dart';

class ValueDetailPage extends StatefulWidget {
  final ValueSearch valueSearch;
  final List<CandidateProductName> candidateNames;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final void Function(bool, dynamic) onPopInvoked;
  final void Function(String productName, String platform) onLaunchSearchUrl;
  final Function(ItemKeepStatus)? onStatusChanged;
  final Function(ItemKeepStatus status, int? price)? onSave;

  const ValueDetailPage({
    super.key,
    required this.valueSearch,
    required this.candidateNames,
    required this.onEdit,
    required this.onDelete,
    required this.onPopInvoked,
    required this.onLaunchSearchUrl,
    this.onStatusChanged,
    this.onSave,
  });

  @override
  State<ValueDetailPage> createState() => _ValueDetailPageState();
}

class _ValueDetailPageState extends State<ValueDetailPage> {
  late ItemKeepStatus _currentStatus;
  late int? _currentPrice;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.valueSearch.status;
    _currentPrice = widget.valueSearch.value;
  }

  void _onStatusChanged(ItemKeepStatus status) {
    setState(() {
      _currentStatus = status;
    });
  }

  void _onPriceChanged(int? price) {
    setState(() {
      _currentPrice = price;
    });
  }

  void _onSave() {
    widget.onSave?.call(_currentStatus, _currentPrice);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: widget.onPopInvoked,
      child: Scaffold(
        appBar: AppBarComponent(
          title: '価値詳細',
          titleIcon: Icons.info,
          showBackButton: true,
          actions: [
            IconButton(
              onPressed: widget.onDelete,
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
              ValueInfo(
                valueSearch: widget.valueSearch.copyWith(
                  status: _currentStatus,
                  value: _currentPrice,
                ),
                onStatusChanged: _onStatusChanged,
                onPriceChanged: _onPriceChanged,
              ),
              if (widget.valueSearch.imagePaths.isNotEmpty) ...[
                const SizedBox(height: 16),
                ValueImages(imagePaths: widget.valueSearch.imagePaths),
              ],
              if (widget.candidateNames.isNotEmpty) ...[
                const SizedBox(height: 16),
                SearchUrlsSection(
                  candidateNames: widget.candidateNames,
                  onLaunchSearchUrl: widget.onLaunchSearchUrl,
                ),
              ],
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onSave,
          backgroundColor: AppColors.primary,
          tooltip: '保存',
          child: const Icon(Icons.save, color: Colors.white),
        ),
      ),
    );
  }
}
