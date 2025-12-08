import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/theme/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.black.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        titleSpacing: 25,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        shadowColor: AppColors.black,
        centerTitle: false,
        // actionsPadding: EdgeInsets.only(right: 25),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
        // ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
