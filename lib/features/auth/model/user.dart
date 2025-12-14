import 'package:cream_sns/features/profile/model/profile.dart';

class User {
  final String id;
  final String userId;
  final String nickname;
  final String description;
  final ProfileImage profile;

  User({
    required this.id,
    required this.userId,
    required this.nickname,
    required this.description,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      nickname: json['nickname'],
      description: json['description'],
      profile: ProfileImage.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }
}
