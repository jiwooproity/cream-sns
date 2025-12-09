class Profile {
  final String id;
  final String nickname;
  final String description;
  final String image;
  final int postLength;
  final int likeLength;

  Profile({
    required this.id,
    required this.nickname,
    required this.description,
    required this.image,
    required this.postLength,
    required this.likeLength,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      nickname: json['nickname'],
      description: json['description'],
      image: json['image'],
      postLength: json['postLength'],
      likeLength: json['likeLength'],
    );
  }
}
