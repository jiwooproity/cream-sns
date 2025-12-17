import 'package:cream_sns/shared/models/image.dart';

class Post {
  final String id;
  final String content;
  final Image image;

  Post({required this.id, required this.content, required this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      image: Image.fromJson(json['image'] as Map<String, dynamic>)
    );
  }
}
