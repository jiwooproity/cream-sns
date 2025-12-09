import 'package:cream_sns/features/post/widgets/post_content.dart';
import 'package:cream_sns/features/post/widgets/post_footer.dart';
import 'package:cream_sns/features/post/widgets/post_image.dart';
import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/theme/app_colors.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

// Widget
import 'post_header.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: AppColors.grey,
      color: AppColors.white,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            PostHeader(post: post),
            PostImage(images: post.images),
            SizedBox(height: 8),
            PostContent(content: post.content),
            PostFooter(
              likeLength: post.likeLength,
              commentLength: post.commentLength,
            ),
          ],
        ),
      ),
    );
  }
}
