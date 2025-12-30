import 'package:cream_sns/features/post/ui/comment_input.dart';
import 'package:cream_sns/features/post/ui/comment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Store
import 'package:cream_sns/store/post_store.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/features/post/ui/post_card.dart';
import 'package:cream_sns/shared/loading/custom_indicator.dart';

class PostDetail extends ConsumerWidget {
  const PostDetail({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postStoreProvider)[postId];

    if (post == null) {
      return const CustomIndicator();
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: "게시글",
        titleSize: 15,
        leading: IconButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CommentInput(postId: post.id),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: PostCard(post: post)),
          SliverFillRemaining(child: CommentList(postId: post.id)),
        ],
      ),
    );
  }
}
