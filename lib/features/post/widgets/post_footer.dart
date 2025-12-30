import 'package:cream_sns/features/post/provider/post_provider.dart';
import 'package:cream_sns/store/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

class PostFooter extends ConsumerWidget {
  final PostDetail post;

  const PostFooter({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          spacing: 10,
          children: [
            GestureDetector(
              onTap: () {
                if (post.isLiked) {
                  ref.read(postActionProvider.notifier).cancelLike(post.id);
                } else {
                  ref.read(postActionProvider.notifier).doLike(post.id);
                }
              },
              child: Row(
                spacing: 3,
                children: [
                  Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_outline,
                    size: 20,
                    color: post.isLiked ? Colors.red : Colors.black,
                  ),
                  Text("${post.likeCount}"),
                ],
              ),
            ),
            Row(
              spacing: 3,
              children: [
                const Icon(Icons.comment_outlined, size: 20),
                Text("${post.commentCount}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
