import 'dart:async';

import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class RoundButton extends StatefulWidget {
  final double? height;
  final String btnText;

  final void Function() onPressed;

  const RoundButton({
    super.key,
    this.height = 50,
    required this.onPressed,
    required this.btnText,
  });

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  Timer? _debounce;

  void onTap() {
    if (_debounce?.isActive ?? false) return;

    _debounce = Timer(const Duration(milliseconds: 300), () {});

    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(
          widget.btnText,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}
