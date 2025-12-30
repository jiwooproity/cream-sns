import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:cream_sns/features/like/provider/likes_provider.dart';
import 'package:cream_sns/features/post/ui/post_card.dart';
import 'package:cream_sns/shared/loading/custom_indicator.dart';
import 'package:cream_sns/store/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LikeView extends ConsumerWidget {
  const LikeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authStateProvider).userId!;
    final state = ref.watch(likesProvider(userId));

    return Scaffold(
      appBar: const CustomAppbar(
        title: "좋아요를 누른 게시글",
        centerTitle: true,
        titleSize: 15,
      ),
      body: state.ids.isEmpty
          ? const Center(child: Text("좋아요를 누른 게시글이 없습니다."))
          : ListView.builder(
              itemCount: state.ids.length,
              itemBuilder: (BuildContext context, int idx) {
                final post = ref.watch(postStoreProvider)[state.ids[idx]];
                if (post == null) return const CustomIndicator();
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.push("/post/detail", extra: post.id);
                  },
                  child: PostCard(post: post),
                );
              },
            ),
    );
  }
}
