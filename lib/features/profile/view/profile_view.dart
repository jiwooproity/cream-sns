import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Navigation
import 'package:cream_sns/core/widgets/custom_appbar.dart';

// Widgets
import 'package:cream_sns/features/profile/widgets/profile_info.dart';
import 'package:cream_sns/features/profile/tabs/tabs_grid.dart';
import 'package:cream_sns/features/profile/modal/profile_bottom_modal.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: authState.user?.userId ?? "",
        titleSize: 15,
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
        actions: [
          GestureDetector(
            child: Icon(Icons.more_horiz),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ProfileBottomModal(),
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ?authState.user != null ? ProfileInfo(user: authState.user!) : null,
            SizedBox(height: 15),
            TabBar(
              labelColor: AppColors.blue,
              indicatorColor: AppColors.blue,
              tabs: [
                Tab(icon: Icon(Icons.grid_on_outlined)),
                Tab(icon: Icon(Icons.favorite_outline)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PostTab(post: []),
                  Center(child: Text("멘션 리스트")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
