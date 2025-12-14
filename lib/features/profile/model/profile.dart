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

class ProfileImage {
  final String url;
  final String publicId;

  ProfileImage({required this.url, required this.publicId});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      url: json['url'],
      publicId: json['public_id']
    );
  }
}
