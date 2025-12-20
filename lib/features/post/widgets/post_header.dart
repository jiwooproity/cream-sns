import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Provider
import 'package:cream_sns/features/post/provider/action_provider.dart';
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

// Widgets
import 'package:cream_sns/shared/widgets/buttons/tile_text_button.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/shared/widgets/time/time_ago.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';

class PostHeader extends ConsumerWidget {
  final PostDetail post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myId = ref.watch(authStateProvider).userId!;

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => showProfile(context),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(post.author.profile.url),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author.nickname,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ConvertTime(
                      msEpoch: post.createdAt,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (post.author.id == myId)
            CustomModal(
              icon: Icons.more_vert,
              children: [
                TileTextButton("게시글 수정", onTap: () => editPost(context, post)),
                const CustomDivider(height: 1),
                TileTextButton("게시글 삭제", onTap: () => deletePost(context, ref)),
              ],
            ),
        ],
      ),
    );
  }

  void editPost(BuildContext context, PostDetail post) {
    if (context.mounted) {
      context.pop();
      final extra = Post(id: post.id, content: post.content, image: post.image);
      context.push("/post/edit", extra: extra);
    }
  }

  void deletePost(BuildContext context, WidgetRef ref) async {
    if (context.mounted) context.pop();

    await ref
        .read(postActionProvider)
        .deletePost(postId: post.id, authorId: post.author.id);

    if (context.mounted) context.pop();
  }

  void showProfile(BuildContext context) {
    if (context.mounted) context.push("/profile/${post.author.id}");
  }
}
