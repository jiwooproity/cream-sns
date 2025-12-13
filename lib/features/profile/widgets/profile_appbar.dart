import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

class ProfileAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authStateProvider.select((s) => s.user?.userId));

    return CustomAppbar(
      title: userId ?? "",
      titleSize: 15,
      centerTitle: true,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
      actions: [
        CustomModal(
          icon: Icons.more_horiz,
          widgets: [
            editTile(ref),
            const CustomDivider(),
            logoutTile(ref)
          ],
        ),
      ],
    );
  }
  
  Widget editTile(WidgetRef ref) {
    return ListTile(
      onTap: () {
        ref.context.pop();
        ref.context.push("/profile/edit");
      },
      title: const Center(child: Text("프로필 편집")),
    );
  }

  Widget logoutTile(WidgetRef ref) {
    return ListTile(
      onTap: () async {
        final res = await ref.read(authStateProvider.notifier).logout();
        if(res.statusCode == 200 && ref.context.mounted) {
          ref.context.go("/login");
        }
      },
      title: const Center(
        child: Text("로그아웃", style: TextStyle(color: Colors.red)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
