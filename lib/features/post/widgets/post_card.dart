import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Models
import 'package:cream_sns/features/home/model/feed.dart';

// Widget
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/features/post/widgets/post_header.dart';
import 'package:cream_sns/features/post/widgets/post_content.dart';
import 'package:cream_sns/features/post/widgets/post_footer.dart';
import 'package:cream_sns/features/post/widgets/post_image.dart';
import 'package:go_router/go_router.dart';

class PostCard extends StatelessWidget {
  final Feed feed;

  const PostCard({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: AppColors.grey,
      color: AppColors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context.push("/post/detail", extra: feed.id);
        },
        child: Column(
          children: [
            PostHeader(feed: feed),
            PostImage(image: feed.image.url),
            PostContent(content: feed.content),
            const PostFooter(likeLength: 0, commentLength: 0),
            const CustomDivider(height: 25),
          ],
        ),
      ),
    );
  }
}
