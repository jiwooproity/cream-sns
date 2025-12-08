import 'package:flutter/material.dart';

import 'package:cream_sns/features/post/models/post.dart';
import 'package:cream_sns/features/post/widgets/post_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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

  late final List<Post> postList = [post, post, post];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: postList.map((post) => PostCard(post: post)).toList(),
      ),
    );
  }
}
