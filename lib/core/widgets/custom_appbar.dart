import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? titleSize;
  final bool? centerTitle;
  final EdgeInsetsGeometry? actionsPadding;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppbar({
    super.key,
    required this.title,
    this.titleSize = 20,
    this.centerTitle = false,
    this.actionsPadding = EdgeInsets.zero,
    this.actions,
    this.leading
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.grey, height: 1),
      ),
      leading: leading,
      leadingWidth: 40,
      titleSpacing: 15,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      shadowColor: AppColors.black,
      centerTitle: centerTitle,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      actionsPadding: actionsPadding,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
