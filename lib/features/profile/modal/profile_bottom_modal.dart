import 'package:flutter/material.dart';

// Library
import 'package:go_router/go_router.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class ProfileBottomModal extends StatelessWidget {
  const ProfileBottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
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
              context.push("/profile/edit");
            },
            title: Center(child: Text("프로필 수정")),
          ),
        ],
      ),
    );
  }
}
