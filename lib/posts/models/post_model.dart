class PostModel {
  final String id;
  final String postId;
  final String title;
  final String date;
  final String description;
  final String imageLink;
  final List<String> comments;

  PostModel(
      {required this.id,
      required this.postId,
      required this.title,
      required this.date,
      required this.description,
      required this.imageLink,
      required this.comments});
}
