class PostModel {
  final num id;
  final String title;
  final String body;
  final num userId;
  PostModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.userId});
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        userId: json['userId']);
  }
}
