class ServerImage {
  final String url;
  final String publicId;

  ServerImage({required this.url, required this.publicId});

  factory ServerImage.fromJson(Map<String, dynamic> json) {
    return ServerImage(
        url: json['url'],
        publicId: json['public_id']
    );
  }
}