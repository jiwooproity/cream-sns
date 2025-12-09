import 'package:cream_sns/theme/colors.dart';
import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/profile/model/profile.dart';

// Widgets
import 'package:cream_sns/navigation/custom_appbar.dart';
import 'package:cream_sns/features/profile/widgets/profile_info.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Profile _profile = Profile(
    id: "mattinew_0208",
    nickname: "마띠뉴",
    description: "안녕하세요, 프론트엔드 개발자 소지우입니다.",
    image: "https://avatars.githubusercontent.com/u/58384366?v=4",
    likeLength: 1,
    postLength: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: _profile.id,
        titleSize: 15,
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 12),
        actions: [Icon(Icons.more_horiz)],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ProfileInfo(profile: _profile),
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
                  Center(child: Text("게시글 리스트")),
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
