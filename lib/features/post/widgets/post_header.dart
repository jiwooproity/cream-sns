import 'package:cream_sns/shared/widgets/convert_time.dart';
import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              "https://avatars.githubusercontent.com/u/58384366?v=4&size=64",
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.nickname,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ConvertTime(
                  msEpoch: post.createTime,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          GestureDetector(onTap: () {}, child: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
