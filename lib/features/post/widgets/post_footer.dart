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
      padding: EdgeInsets.all(12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          spacing: 5,
          children: [
            Icon(Icons.favorite_outline, size: 20),
            Text("$likeLength"),
            Icon(Icons.comment_outlined, size: 20),
            Text("$commentLength"),
          ],
        ),
      ),
    );
  }
}
