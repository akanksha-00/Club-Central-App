import 'package:club_central/posts/models/comment_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

abstract class PostsEvents {}

class GetPostsEvent extends PostsEvents {
  final ObjectId instituteId;

  GetPostsEvent({required this.instituteId});
}

class AddComment extends PostsEvents {
  final String userName;
  final String commentText;
  final ObjectId postId;

  

  AddComment(
      {required this.userName,
      required this.commentText,
      required this.postId});
}

class DeleteComment extends PostsEvents {
  final ObjectId postId;
  final int index;

  DeleteComment({required this.postId, required this.index});
}

class FetchComments extends PostsEvents {}
