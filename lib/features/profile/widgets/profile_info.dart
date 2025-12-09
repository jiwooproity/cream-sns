import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/profile/model/profile.dart';

// Widgets
import 'package:cream_sns/features/profile/widgets/profile_detail.dart';
import 'package:cream_sns/features/profile/widgets/profile_image.dart';

class ProfileInfo extends StatelessWidget {
  final Profile profile;

  const ProfileInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        ProfileImage(image: profile.image),
        SizedBox(height: 15),
        ProfileDetail(nickname: profile.nickname, description: profile.description),
      ],
    );
  }
}
