import 'package:mongo_dart/mongo_dart.dart';

class CommentsModel {
  final ObjectId postId;
  
  String user = "User";
  String commentText = "Comment";

  CommentsModel({required this.postId});

  void getCommentFromRawComment(String rawComment) {
    print(rawComment);
    List<String> split = rawComment.split('-');
    user = split[0];
    commentText = split[1];
  }

  String convertToRawComment() {
    String rawComment = user + '-' + commentText;
    return rawComment;
  }
}
