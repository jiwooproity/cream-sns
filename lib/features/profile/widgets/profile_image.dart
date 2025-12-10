import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String image;

  const ProfileImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(radius: 50, backgroundImage: NetworkImage(image)),
    );
  }
}
