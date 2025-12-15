import 'package:cream_sns/shared/models/image.dart';

class Post {
  final String postId;
  final String content;
  final Image image;

  Post({required this.postId, required this.content, required this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      content: json['content'],
      image: Image.fromJson(json['image'] as Map<String, dynamic>)
    );
  }
}
