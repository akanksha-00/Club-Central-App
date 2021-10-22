import 'package:club_central/posts/models/comment_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

abstract class PostsEvents {}

class GetPostsEvent extends PostsEvents {
  final ObjectId instituteId;

  GetPostsEvent({required this.instituteId});
}

class AddComment extends PostsEvents {
  final CommentsModel comment;
  final ObjectId postId;

  AddComment({required this.comment, required this.postId});
}

class FetchComments extends PostsEvents {}
