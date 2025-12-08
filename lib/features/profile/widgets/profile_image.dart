import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String profile;

  const ProfileImage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/58384366?v=4&size=64",
          ),
        ),
      ),
    );
  }
}
