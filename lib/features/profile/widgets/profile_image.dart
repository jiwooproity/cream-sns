import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String image;

  const ProfileImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircleAvatar(backgroundImage: NetworkImage(image)),
      ),
    );
  }
}
