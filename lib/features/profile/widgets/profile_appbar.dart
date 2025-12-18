import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/profile/model/profile.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:cream_sns/features/profile/provider/profile_provider.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/shared/widgets/buttons/tile_text_button.dart';
import 'package:cream_sns/shared/loading/custom_indicator.dart';

class ProfileAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const ProfileAppbar({super.key, required this.targetId, required this.isMe});

  final String targetId;
  final bool isMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(targetId));

    return profileAsync.when(
      data: (profile) {
        return CustomAppbar(
          title: profile.userId,
          titleSize: 15,
          centerTitle: true,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
          actions: [
            CustomModal(
              icon: Icons.more_horiz,
              children: [
                TileTextButton(
                  isMe ? "프로필 편집" : "팔로우",
                  onTap: () => isMe ? editProfile(ref, profile) : () {},
                ),
                const CustomDivider(),
                if (isMe)
                  TileTextButton(
                    "로그아웃",
                    onTap: () => logout(ref),
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        );
      },
      error: (err, stack) => const Text("프로필 ID 조회에 실패하였습니다."),
      loading: () => const CustomIndicator(),
    );
  }

  void editProfile(WidgetRef ref, Profile profile) {
    ref.context.pop();
    ref.context.push("/profile/edit", extra: profile);
  }

  Future<void> logout(WidgetRef ref) async {
    final res = await ref.read(authStateProvider.notifier).logout();
    if (res.statusCode == 200 && ref.context.mounted) {
      ref.context.go("/login");
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
