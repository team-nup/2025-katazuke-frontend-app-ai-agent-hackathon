import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/value_search.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import 'status_selector.dart';

class ValueInfo extends StatefulWidget {
  final ValueSearch valueSearch;
  final Function(ItemKeepStatus)? onStatusChanged;
  final Function(int?)? onPriceChanged;

  const ValueInfo({
    super.key,
    required this.valueSearch,
    this.onStatusChanged,
    this.onPriceChanged,
  });

  @override
  State<ValueInfo> createState() => _ValueInfoState();
}

class _ValueInfoState extends State<ValueInfo> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(
      text: widget.valueSearch.value?.toString() ?? '',
    );
  }

  @override
  void didUpdateWidget(ValueInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueSearch.value != widget.valueSearch.value) {
      _priceController.text = widget.valueSearch.value?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '推測された商品名',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                ),
                Text(
                  widget.valueSearch.detectedProductName ?? '不明な商品',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            const SizedBox(height: 16),
            _buildPriceInput(),
            const SizedBox(height: 16),
            StatusSelector(
              currentStatus: widget.valueSearch.status,
              onStatusChanged: widget.onStatusChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'およその価格',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _priceController,
          decoration: InputDecoration(
            prefixText: '¥ ',
            prefixStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          onChanged: (value) {
            final price = int.tryParse(value);
            widget.onPriceChanged?.call(price);
          },
        ),
      ],
    );
  }
}
