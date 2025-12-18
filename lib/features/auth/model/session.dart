class Session {
  Session({required this.id});

  final String id;

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(id: json['id']);
  }
}