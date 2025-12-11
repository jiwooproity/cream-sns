class Profile {
  final String id;
  final String nickname;
  final String description;
  final String image;

  Profile({
    required this.id,
    required this.nickname,
    required this.description,
    required this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      nickname: json['nickname'],
      description: json['description'],
      image: json['image'],
    );
  }
}
