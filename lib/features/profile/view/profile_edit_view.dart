import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Center(
        child: Text(
          "Edit Profile View",
          style: TextStyle(fontSize: 12, color: AppColors.black),
        ),
      ),
    );
  }
}
