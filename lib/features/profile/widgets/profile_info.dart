import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/auth/provider/user_provider.dart';
import 'package:cream_sns/shared/widgets/buttons/round_button.dart';
import 'package:go_router/go_router.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key, this.targetId});

  final String? targetId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              ProfileImage(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileCount(count: 1, title: "게시글"),
                    ProfileCount(count: 1, title: "팔로워"),
                    ProfileCount(count: 1, title: "팔로잉"),
                  ],
                ),
              ),
            ],
          ),
          const CustomDivider(height: 31),
          const ProfileDetail(),
          const SizedBox(height: 15),
          InterActionButton(targetId: targetId),
        ],
      ),
    );
  }
}

class InterActionButton extends ConsumerWidget {
  const InterActionButton({super.key, this.targetId});

  final String? targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return targetId == null
        ? RoundButton(
            onPressed: () => context.push("/profile/edit"),
            btnText: "프로필 편집",
          )
        : RoundButton(onPressed: () {}, btnText: "팔로우");
  }
}

class ProfileCount extends StatelessWidget {
  const ProfileCount({super.key, required this.count, required this.title, this.targetId});

  final String? targetId;
  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$count",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(title, style: const TextStyle(fontSize: 12)),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nickname ?? "",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(description ?? "", style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
