class CommentsModel {
  String user = "User";
  String commentText = "Comment";

  void getCommentFromRawComment(String rawComment) {
    print(rawComment);
    List<String> split = rawComment.split(':');
    user = split[0];
    commentText = split[1];
  }

  String convertToRawComment() {
    String rawComment = user + ':' + commentText;
    return rawComment;
  }
}
