import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  final int likeLength;
  final int commentLength;

  const PostFooter({
    super.key,
    required this.likeLength,
    required this.commentLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          spacing: 10,
          children: [
            Row(
              spacing: 3,
              children: [
                const Icon(Icons.favorite_outline, size: 20),
                Text("$likeLength"),
              ],
            ),
            Row(
              spacing: 3,
              children: [
                const Icon(Icons.comment_outlined, size: 20),
                Text("$commentLength"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
