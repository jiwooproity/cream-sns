import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const ActionButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }
}
