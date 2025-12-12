import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as time_ago;

class ConvertTime extends StatelessWidget {
  final int msEpoch;
  final TextStyle? style;

  const ConvertTime({super.key, required this.msEpoch, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      time_ago.format(DateTime.fromMillisecondsSinceEpoch(msEpoch), locale: 'ko'),
      style: style ?? const TextStyle(fontSize: 16),
    );
  }
}
