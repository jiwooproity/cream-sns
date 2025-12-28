import 'package:cream_sns/features/post/models/author.dart';

class Comment {
  final String id;
  final String postId;
  final String content;
  final Author author;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'],
      content: json['content'],
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );
  }
}
