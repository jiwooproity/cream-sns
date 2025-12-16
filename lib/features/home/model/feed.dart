import 'package:cream_sns/shared/models/image.dart';

class Feed {
  final String postId;
  final String content;
  final Image image;
  final int createdAt;
  final FeedAuthor user;

  Feed({
    required this.postId,
    required this.content,
    required this.image,
    required this.createdAt,
    required this.user,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      postId: json['postId'],
      content: json['content'],
      image: Image.fromJson(json['image'] as Map<String, dynamic>),
        createdAt: json['createdAt'],
      user: FeedAuthor.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class FeedAuthor {
  final String userId;
  final String nickname;
  final Image profile;

  FeedAuthor({
    required this.userId,
    required this.nickname,
    required this.profile,
  });

  factory FeedAuthor.fromJson(Map<String, dynamic> json) {
    return FeedAuthor(
      userId: json['userId'],
      nickname: json['nickname'],
      profile: Image.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }
}
