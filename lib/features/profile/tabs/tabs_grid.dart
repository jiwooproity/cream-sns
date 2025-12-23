import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:cream_sns/features/like/provider/likes_provider.dart';
import 'package:cream_sns/store/index_state.dart';
import 'package:cream_sns/store/post_store.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/post_provider.dart';

// Widgets
import 'package:cream_sns/shared/loading/custom_indicator.dart';

class PostTab extends ConsumerWidget {
  const PostTab({super.key, required this.gridType, required this.targetId});

  final String gridType;
  final String targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final IndexState state;

    if(gridType == "작성글") {
      state = ref.watch(postProvider(targetId));
    }

    if(gridType == "좋아요") {
      state = ref.watch(likesProvider(targetId));
    }

    if (state.isLoading) {
      return const CustomIndicator();
    }

    if (state.ids.isEmpty) {
      return const Center(child: Text("작성한 게시글이 없습니다."));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: state.ids.length,
      itemBuilder: (context, index) {
        final post = ref.watch(postStoreProvider)[state.ids[index]];
        if (post == null) return const CustomIndicator();
        return GestureDetector(
          onTap: () {
            final id = post.id;
            context.push("/post/detail", extra: id);
          },
          child: Image.network(post.image.url, fit: BoxFit.cover),
        );
      },
    );
  }
}
