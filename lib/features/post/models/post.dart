import 'package:cream_sns/shared/models/server_image.dart';

class Post {
  final String id;
  final String content;
  final ServerImage image;

  Post({required this.id, required this.content, required this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        content: json['content'],
        image: ServerImage.fromJson(json['image'] as Map<String, dynamic>)
    );
  }
}

class PostDetail {
  final String id;
  final String content;
  final ServerImage image;
  final int createdAt;
  final PostAuthor author;

  PostDetail({
    required this.id,
    required this.content,
    required this.image,
    required this.createdAt,
    required this.author,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
      id: json['id'],
      content: json['content'],
      image: ServerImage.fromJson(json['image'] as Map<String, dynamic>),
      createdAt: json['createdAt'],
      author: PostAuthor.fromJson(json['author'] as Map<String, dynamic>),
    );
  }
}

class PostAuthor {
  final String id;
  final String nickname;
  final ServerImage profile;

  PostAuthor({
    required this.id,
    required this.nickname,
    required this.profile,
  });

  factory PostAuthor.fromJson(Map<String, dynamic> json) {
    return PostAuthor(
      id: json['id'],
      nickname: json['nickname'],
      profile: ServerImage.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }
}
