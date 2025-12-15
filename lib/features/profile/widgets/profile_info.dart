import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/auth/provider/user_provider.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 15),
        ProfileImage(),
        SizedBox(height: 15),
        ProfileDetail(),
      ],
    );
  }
}

// 프로필 이미지
class ProfileImage extends ConsumerWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userStateProvider.select((s) => s.user?.profile));

    if (profile != null) {
      precacheImage(NetworkImage(profile.url), context);

      return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          profile.url,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return const CircleAvatar();
    }
  }
}

// 사용자 정보 ["닉네임", "한 줄 소개"]
class ProfileDetail extends ConsumerWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(
      userStateProvider.select((s) => s.user?.nickname),
    );

    final description = ref.watch(
      userStateProvider.select((s) => s.user?.description),
    );

    return Column(
      children: [
        Text(nickname ?? "", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 2),
        Text(description ?? "", style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
