import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final String image;

  const PostImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image);
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
