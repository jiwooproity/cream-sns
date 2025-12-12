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
        profileDetail(nickname: user.nickname),
      ],
    );
  }

  Widget profileImage({required String profile}) {
    return CircleAvatar(radius: 50, backgroundImage: NetworkImage(profile));
  }

  Widget profileDetail({
    required String nickname,
  }) {
    return Text(
      nickname,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
