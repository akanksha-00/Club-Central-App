import 'package:club_central/posts/models/comment_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class PostModel {
  final ObjectId id;
  final String title;
  final DateTime date;
  final String description;
  final String imageLink;
  final List<CommentsModel> comments;
  final ObjectId clubId;
  final ObjectId instituteId;

  PostModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.imageLink,
    required this.comments,
    required this.clubId,
    required this.instituteId,
  });
}
