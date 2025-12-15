import 'package:flutter/material.dart';

// Widgets
import 'package:cream_sns/features/profile/widgets/profile_appbar.dart';
import 'package:cream_sns/features/profile/widgets/profile_info.dart';
import 'package:cream_sns/features/profile/tabs/tabs_bar.dart';
import 'package:cream_sns/features/profile/tabs/tabs_grid.dart';
import 'package:cream_sns/features/profile/tabs/tabs_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProfileAppbar(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ProfileInfo(),
            SizedBox(height: 15),
            TabsBar(),
            TabsView(
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
