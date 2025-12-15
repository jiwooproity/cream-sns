import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/auth/provider/user_provider.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/shared/widgets/buttons/tile_text_button.dart';

class ProfileAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userStateProvider.select((s) => s.user?.userId));

    return CustomAppbar(
      title: userId ?? "",
      titleSize: 15,
      centerTitle: true,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
      actions: [
        CustomModal(
          icon: Icons.more_horiz,
          children: [
            TileTextButton("프로필 편집", onTap: () => editProfile(ref)),
            const CustomDivider(),
            TileTextButton("로그아웃", onTap: () => logout(ref), color: Colors.red),
          ],
        ),
      ],
    );
  }

  void editProfile(WidgetRef ref) {
    ref.context.pop();
    ref.context.push("/profile/edit");
  }

  Future<void> logout(WidgetRef ref) async {
    final res = await ref.read(userStateProvider.notifier).logout();
    if (res.statusCode == 200 && ref.context.mounted) {
      ref.context.go("/login");
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
