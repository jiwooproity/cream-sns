import 'package:cream_sns/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  final String hintText;
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        TextField(
          controller: textEditingController,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.black),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
