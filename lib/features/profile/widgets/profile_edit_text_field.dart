import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class ProfileEditTextField extends StatelessWidget {
  final TextEditingController controller;

  const ProfileEditTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintStyle: TextStyle(fontSize: 14),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.black),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      ),
    );
  }
}
