import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color color;

  const CustomDivider({
    super.key,
    this.height = 0,
    this.thickness = 1,
    this.color = AppColors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, color: color, thickness: thickness);
  }
}
