import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? titleSize;
  final bool? centerTitle;
  final EdgeInsetsGeometry? actionsPadding;
  final List<Widget>? actions;

  const CustomAppbar({
    super.key,
    required this.title,
    this.titleSize = 20,
    this.centerTitle = false,
    this.actionsPadding = EdgeInsets.zero,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
      ),
      titleSpacing: 29,
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
  Size get preferredSize => Size.fromHeight(50);
}
