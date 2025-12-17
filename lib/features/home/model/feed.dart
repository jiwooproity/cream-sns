import 'package:cream_sns/shared/models/image.dart';

class Feed {
  final String id;
  final String content;
  final Image image;
  final int createdAt;
  final FeedAuthor author;

  Feed({
    required this.id,
    required this.content,
    required this.image,
    required this.createdAt,
    required this.author,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      content: json['content'],
      image: Image.fromJson(json['image'] as Map<String, dynamic>),
      createdAt: json['createdAt'],
      author: FeedAuthor.fromJson(json['author'] as Map<String, dynamic>),
    );
  }
}

class FeedAuthor {
  final String id;
  final String nickname;
  final Image profile;

  FeedAuthor({
    required this.id,
    required this.nickname,
    required this.profile,
  });

  factory FeedAuthor.fromJson(Map<String, dynamic> json) {
    return FeedAuthor(
      id: json['id'],
      nickname: json['nickname'],
      profile: Image.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }
}
