import 'package:flutter/material.dart';

class TileTextButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color? color;

  const TileTextButton(this.text, {super.key, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 65,
      onTap: () => onTap(),
      title: Center(
        child: Text(text, style: TextStyle(color: color)),
      ),
    );
  }
}
