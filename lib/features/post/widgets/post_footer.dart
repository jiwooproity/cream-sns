import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

class PostFooter extends StatelessWidget {
  final PostDetail post;

  const PostFooter({
    super.key,
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          spacing: 10,
          children: [
            Row(
              spacing: 3,
              children: [
                const Icon(Icons.favorite_outline, size: 20),
                Text("${post.likeCount}"),
              ],
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
