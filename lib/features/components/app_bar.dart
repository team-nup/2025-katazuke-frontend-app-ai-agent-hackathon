import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? titleIcon;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;

  const AppBarComponent({
    super.key,
    required this.title,
    this.titleIcon,
    this.actions,
    this.leading,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          if (titleIcon != null) ...[
            Icon(
              titleIcon,
              color: AppColors.textPrimary,
              size: 24,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primaryMedium,
      elevation: 0,
      leading: leading,
      automaticallyImplyLeading: showBackButton,
      actions: actions,
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
