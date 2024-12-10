class Badge {
  final int id;
  final int? userId;
  final String uid;

  const Badge({
    required this.id,
    this.userId,
    required this.uid,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        id: json["id"],
        userId: json["userId"],
        uid: json["uid"],
      );
}
