import 'package:cream_sns/features/post/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/post_provider.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';

class PostDetail extends ConsumerWidget {
  const PostDetail({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postDetailProvider(postId));

    return Scaffold(
      appBar: const CustomAppbar(title: "게시글", titleSize: 15),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: postAsync.when(
          data: (post) => PostCard(feed: post),
          error: (err, stack) {
            return const Center(child: Text("게시글 조회를 실패하였습니다."));
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
