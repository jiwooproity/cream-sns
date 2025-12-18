import 'package:cream_sns/shared/models/server_image.dart';

class Profile {
  final String id;
  final String userId;
  final String nickname;
  final String description;
  final ServerImage profile;

  Profile({
    required this.id,
    required this.userId,
    required this.nickname,
    required this.description,
    required this.profile,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userId: json['userId'],
      nickname: json['nickname'],
      description: json['description'],
      profile: ServerImage.fromJson(json['profile']),
    );
  }
}

class EditParams {
  EditParams({required this.nickname, required this.description});

  final String nickname;
  final String description;
}