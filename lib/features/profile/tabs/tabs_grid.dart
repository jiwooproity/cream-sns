import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/post_provider.dart';

// Widgets
import 'package:cream_sns/shared/loading/custom_indicator.dart';

class PostTab extends ConsumerWidget {
  const PostTab({super.key, required this.targetId});

  final String targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(myPostProvider(targetId));

    return postAsync.when(
      data: (posts) {
        if (posts.isNotEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final id = posts[index].id;
                  context.push("/post/detail", extra: id);
                },
                child: Image.network(posts[index].image.url, fit: BoxFit.cover),
              );
            },
          );
        } else {
          return const Center(child: Text("등록한 게시글이 없습니다."));
        }
      },
      error: (err, stack) => const Center(child: Text("게시글 조회에 실패하였습니다.")),
      loading: () => const CustomIndicator(),
    );
  }
}
