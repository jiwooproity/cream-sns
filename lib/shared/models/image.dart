class Image {
  final String url;
  final String publicId;

  Image({required this.url, required this.publicId});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
        url: json['url'],
        publicId: json['public_id']
    );
  }
}