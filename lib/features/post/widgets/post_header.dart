import 'package:cream_sns/features/home/model/feed.dart';
import 'package:cream_sns/shared/widgets/time/time_ago.dart';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final Feed feed;

  const PostHeader({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              feed.author.profile.url,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feed.author.nickname,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ConvertTime(
                  msEpoch: feed.createdAt,
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
