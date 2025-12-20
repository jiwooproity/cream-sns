import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/auth/model/user.dart';
import 'package:cream_sns/shared/models/server_image.dart';
import 'package:go_router/go_router.dart';

class UserBox extends StatelessWidget {
  const UserBox({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => showProfile(context),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImage(image: user.profile),
          Text(
            user.nickname,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void showProfile(BuildContext context) {
    if(context.mounted) context.push("/profile/${user.id}");
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.image});

  final ServerImage image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(image.url, width: 30, height: 30, fit: BoxFit.cover),
    );
  }
}
