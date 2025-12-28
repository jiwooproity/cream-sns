import 'package:cream_sns/shared/models/server_image.dart';

class Author {
  final String id;
  final String nickname;
  final ServerImage profile;

  Author({required this.id, required this.nickname, required this.profile});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      nickname: json['nickname'],
      profile: ServerImage.fromJson(json['profile'] as Map<String, dynamic>),
    );
  }
}
