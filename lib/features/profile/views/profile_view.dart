import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Widgets
import 'package:cream_sns/features/profile/widgets/profile_appbar.dart';
import 'package:cream_sns/features/profile/widgets/profile_info.dart';
import 'package:cream_sns/features/profile/tabs/tabs_grid.dart';
import 'package:cream_sns/features/profile/tabs/tabs_view.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key, this.targetId});

  final String? targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final loginId = authState.userId;

    if (loginId == null) {
      return const SizedBox.shrink();
    }

    final id = targetId ?? loginId;
    final isMe = id == loginId;

    return Scaffold(
      appBar: ProfileAppbar(targetId: id, isMe: isMe),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ProfileInfo(myId: loginId,targetId: id, isMe: isMe),
            const TabBar(
              labelColor: AppColors.black,
              indicatorColor: AppColors.black,
              tabs: [
                Tab(child: Icon(Icons.grid_on_outlined)),
                Tab(child: Icon(Icons.favorite_outline)),
              ],
            ),
            TabsView(
              children: [
                PostTab(targetId: id),
                const Center(child: Text("좋아요를 누른 게시글이 없습니다.")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
