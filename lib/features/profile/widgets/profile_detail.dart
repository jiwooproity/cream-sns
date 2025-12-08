import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final String nickname;

  const ProfileDetail({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            nickname,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
