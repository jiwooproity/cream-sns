import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/features/post/models/post.dart';
import 'package:cream_sns/features/post/widgets/post_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ImagePicker _picker = ImagePicker();

  final Post post = Post(
    user: 1,
    nickname: "마띠뉴",
    images: [
      "https://i.namu.wiki/i/EhRuHPh2gVYjsfkfqsLKkmydpuvniZ4m0bYuRMQuOgb5lmqHAlyG1KvSSaM1kSh_frfCDLQ-VDLF79vhYPKAGQ.webp",
    ],
    content: "림버스 컴퍼니 재밌다\n완전 혜자 게임에 노력만 하면 모든 캐릭을 얻을 수 있다고 ..?\n말이 되는 건가?",
    likeLength: 2,
    commentLength: 0,
    createTime: DateTime.now().millisecondsSinceEpoch,
  );

  late final List<Post> postList = [post];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Cream",
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
        actions: [
          CustomModal(
            icon: Icons.post_add_outlined,
            widgets: [
              ListTile(
                onTap: () {
                  doPost(context, ImageSource.camera);
                },
                title: const Center(child: Text("카메라")),
              ),
              const CustomDivider(),
              ListTile(
                onTap: () {
                  doPost(context, ImageSource.gallery);
                },
                title: const Center(child: Text("갤러리")),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: postList.length,
              itemBuilder: (BuildContext context, int idx) {
                return PostCard(post: postList[idx]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> doPost(BuildContext context, ImageSource imageSource) async {
    final image = await _picker.pickImage(
      source: imageSource,
      imageQuality: 85,
    );

    if(context.mounted && image != null) {
      context.push("/post/create", extra: image);
    }
  }
}
