import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/profile/provider/profile_provider.dart';

// Models
import 'package:cream_sns/features/profile/model/profile.dart';

// Widgets
import 'package:cream_sns/shared/widgets/buttons/round_button.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/shared/loading/custom_indicator.dart';
import 'package:cream_sns/shared/models/server_image.dart';

class ProfileInfo extends ConsumerWidget {
  const ProfileInfo({super.key, required this.targetId, required this.isMe});

  final String targetId;
  final bool isMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(targetId));

    return profileAsync.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ProfileImage(profile: user.profile),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfileCount(count: user.postCount, title: "게시글"),
                        ProfileCount(count: user.followerCount, title: "팔로워"),
                        ProfileCount(count: user.followingCount, title: "팔로잉"),
                      ],
                    ),
                  ),
                ],
              ),
              const CustomDivider(height: 31),
              ProfileDetail(
                nickname: user.nickname,
                description: user.description,
              ),
              const SizedBox(height: 15),
              InterActionButton(isMe: isMe, user: user),
            ],
          ),
        );
      },
      error: (err, stack) => const Center(child: Text("프로필 조회를 실패하였습니다.")),
      loading: () => const CustomIndicator(),
    );
  }
}

class InterActionButton extends ConsumerWidget {
  const InterActionButton({super.key, required this.user, required this.isMe});

  final bool isMe;
  final Profile user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isMe
        ? RoundButton(
            onPressed: () => context.push("/profile/edit", extra: user),
            btnText: "프로필 편집",
          )
        : RoundButton(onPressed: () {}, btnText: "팔로우");
  }
}

class ProfileCount extends StatelessWidget {
  const ProfileCount({
    super.key,
    required this.count,
    required this.title,
    this.targetId,
  });

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
  const ProfileImage({super.key, required this.profile});

  final ServerImage profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  }
}

// 사용자 정보 ["닉네임", "한 줄 소개"]
class ProfileDetail extends ConsumerWidget {
  const ProfileDetail({
    super.key,
    required this.nickname,
    required this.description,
  });

  final String nickname;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nickname,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
