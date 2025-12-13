import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final List<String> images;

  const PostImage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return images.length == 1
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(images.first, fit: BoxFit.cover),
          )
        : AspectRatio(
            aspectRatio: 16 / 9,
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.network(images[index], fit: BoxFit.cover);
              },
            ),
          );
  }
}
