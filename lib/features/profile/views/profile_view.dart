import 'package:flutter/material.dart';

// Widgets
import 'package:cream_sns/features/profile/widgets/profile_appbar.dart';
import 'package:cream_sns/features/profile/widgets/profile_info.dart';
import 'package:cream_sns/features/profile/tabs/tabs_bar.dart';
import 'package:cream_sns/features/profile/tabs/tabs_grid.dart';
import 'package:cream_sns/features/profile/tabs/tabs_view.dart';

class ProfileView extends StatelessWidget {
  final String? targetId;

  const ProfileView({super.key, this.targetId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppbar(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ProfileInfo(targetId: targetId),
            const SizedBox(height: 15),
            const TabsBar(),
            const TabsView(
              children: [
                PostTab(),
                Center(child: Text("멘션 리스트")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
