import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Library
import 'package:go_router/go_router.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class ProfileBottomModal extends ConsumerWidget {
  const ProfileBottomModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 112,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              context.pop(context);
              context.push("/profile/edit");
            },
            title: Center(child: Text("프로필 편집")),
          ),
          ListTile(
            onTap: () async {
              final res = await ref.read(authStateProvider.notifier).logout();
              if(res.statusCode == 200 && ref.context.mounted) {
                ref.context.go("/login");
              }
            },
            title: Center(
              child: Text("로그아웃", style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
