import 'package:flutter/material.dart';

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
              color: const Color(0xFF212121),
              size: 24,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF212121),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFE0B2),
      elevation: 0,
      leading: leading,
      automaticallyImplyLeading: showBackButton,
      actions: actions,
      iconTheme: const IconThemeData(
        color: Color(0xFF212121),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
