import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final String nickname;
  final String description;

  const ProfileDetail({
    super.key,
    required this.nickname,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Center(
          child: Text(
            nickname,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
