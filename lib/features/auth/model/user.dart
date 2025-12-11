class User {
  final String id;
  final String userId;
  final String nickname;
  final String profile;

  User({required this.id, required this.userId, required this.nickname, required this.profile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      nickname: json['nickname'],
      profile: json['profile']
    );
  }
}
