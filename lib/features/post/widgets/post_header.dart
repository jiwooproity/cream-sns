import 'package:cream_sns/shared/widgets/time/time_ago.dart';
import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
      child: Row(
        children: [
          const CircleAvatar(
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
                  "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ConvertTime(
                  msEpoch: 1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          GestureDetector(onTap: () {}, child: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
