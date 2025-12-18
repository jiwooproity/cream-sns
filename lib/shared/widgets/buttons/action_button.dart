import 'package:flutter/material.dart';

// Widgets
import 'package:cream_sns/shared/loading/custom_indicator.dart';

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
          ? const CustomIndicator()
          : Text(text, style: const TextStyle(fontSize: 15)),
    );
  }
}
