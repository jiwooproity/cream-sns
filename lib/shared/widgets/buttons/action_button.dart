import 'package:cream_sns/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final bool loading;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.text,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: loading
          ? const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(color: AppColors.black),
            )
          : Text(text, style: const TextStyle(fontSize: 15)),
    );
  }
}
