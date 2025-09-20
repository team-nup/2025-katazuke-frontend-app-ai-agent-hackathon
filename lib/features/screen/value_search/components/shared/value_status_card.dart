import 'package:flutter/material.dart';
import 'package:okataduke/core/models/DB/item_keep_status.dart';
import '../../../../components/status_card.dart' as CommonStatusCard;
import '../../../../utils/status_utils.dart';

class ValueStatusCard extends StatelessWidget {
  final ItemKeepStatus status;
  final Function(ItemKeepStatus) onStatusChanged;

  const ValueStatusCard({
    super.key,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CommonStatusCard.StatusCard<ItemKeepStatus>(
      title: '商品はどうする？',
      titleIcon: Icons.inventory_2,
      currentStatus: status,
      options: StatusUtils.itemStatusOptions,
      onStatusChanged: onStatusChanged,
    );
  }
}
