import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/auth/model/user.dart';

class ProfileInfo extends StatelessWidget {
  final User user;

  const ProfileInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        profileImage(profile: user.profile),
        SizedBox(height: 15),
        profileDetail(
          context,
          nickname: user.nickname,
          description: user.description,
        ),
      ],
    );
  }

  Widget profileImage({required String profile}) {
    return CircleAvatar(radius: 50, backgroundImage: NetworkImage(profile));
  }

  Widget profileDetail(
    BuildContext context, {
    required String nickname,
    required String description,
  }) {
    return Column(
      children: [
        Text(
          nickname,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ?description != ""
            ? Text(description, style: Theme.of(context).textTheme.bodyMedium)
            : null,
      ],
    );
  }
}
