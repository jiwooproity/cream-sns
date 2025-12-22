import 'package:cream_sns/shared/models/server_image.dart';

class Profile {
  final String id;
  final String userId;
  final String nickname;
  final String description;
  final ServerImage profile;
  final int postCount;
  final int followerCount;
  final int followingCount;
  final bool isFollowed;

  Profile({
    required this.id,
    required this.userId,
    required this.nickname,
    required this.description,
    required this.profile,
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
    required this.isFollowed,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userId: json['userId'],
      nickname: json['nickname'],
      description: json['description'],
      profile: ServerImage.fromJson(json['profile']),
      postCount: json['postCount'],
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      isFollowed: json['isFollowed'],
    );
  }
}

class EditParams {
  EditParams({required this.nickname, required this.description});

  final String nickname;
  final String description;
}
