import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

class PostTab extends StatelessWidget {
  final List<Post> post;

  const PostTab({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: post.length,
      itemBuilder: (context, index) {
        return Image.network(post[index].images[0], fit: BoxFit.cover);
      },
    );
  }
}
