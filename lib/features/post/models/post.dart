class Post {
  final int user;
  final String nickname;
  final List<String> images;
  final String content;
  final int likeLength;
  final int commentLength;
  final int createTime;

  Post({
    required this.user,
    required this.nickname,
    required this.images,
    required this.content,
    required this.likeLength,
    required this.commentLength,
    required this.createTime,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      user: json['user'] as int,
      nickname: json['nickname'] as String,
      images: json['images'] as List<String>,
      content: json['content'] as String,
      likeLength: json['likeLength'] as int,
      commentLength: json['commentLength'] as int,
      createTime: json['createTime'] as int,
    );
  }
}
