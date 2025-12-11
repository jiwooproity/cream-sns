import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/auth/model/user.dart';

// Widgets
import 'package:cream_sns/features/profile/widgets/profile_detail.dart';
import 'package:cream_sns/features/profile/widgets/profile_image.dart';

class ProfileInfo extends StatelessWidget {
  final User user;

  const ProfileInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        ProfileImage(image: user.profile),
        SizedBox(height: 15),
        ProfileDetail(nickname: user.nickname, description: "안녕하세요, 프론트엔드 개발자 소지우입니다."),
      ],
    );
  }
}
