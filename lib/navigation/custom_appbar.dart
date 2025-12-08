import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/theme/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        titleSpacing: 25,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        shadowColor: AppColors.black,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        // actionsPadding: EdgeInsets.only(right: 25),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
        // ],
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
