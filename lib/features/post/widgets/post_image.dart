import 'package:cream_sns/shared/utils/image_size.dart';
import 'package:flutter/material.dart';

import 'package:cream_sns/core/theme/app_colors.dart';

class PostImage extends StatelessWidget {
  final String image;

  const PostImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageSize>(
      future: getNetworkImageSize(image),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final ratio = isLoading ? 1.0 : getAspectRatio(snapshot.data!);

        return AspectRatio(
          aspectRatio: ratio,
          child: isLoading
              ? Container(
                  color: AppColors.white,
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.black),
                  ),
                )
              : Image.network(image),
        );
      },
    );
    // return Image(
    //   image: NetworkImage(image),
    //   loadingBuilder: (context, child, loading) {
    //     if (loading == null) {
    //       return child;
    //     } else {
    //       return Container(color: AppColors.black);
    //     }
    //   },
    //   fit: BoxFit.cover,
    // );
  }
}
