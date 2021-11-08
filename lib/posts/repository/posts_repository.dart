import 'package:club_central/posts/models/comment_model.dart';
import 'package:club_central/posts/models/post_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class PostsRepository {
  final Db database;
  final ObjectId instituteId;
  final String userName;

  PostsRepository(
      {required this.database,
      required this.instituteId,
      required this.userName});

  List<PostModel> postsList = <PostModel>[];

  Future<void> getPosts() async {
    var coll = database.collection("posts");
    var rawPosts = await coll.find({'InstituteId': instituteId}).toList();
    print("rawposts obtained");

    rawPosts.forEach((post) {
      List<String> rawComments = List<String>.from(post["Comments"]);
      print(post['Comments']);
      List<CommentsModel> comments = <CommentsModel>[];
      if (rawComments.length != 0) {
        rawComments.forEach((rawComment) {
          CommentsModel c = CommentsModel(postId: post['_id']);
          c.getCommentFromRawComment(rawComment);
          comments.add(c);
        });
      }
      print("custom comments created");
      postsList.add(PostModel(
        id: post['_id'],
        title: post['Title'],
        date: post['Date'],
        description: post['Description'],
        imageLink: post['ImageLink'],
        comments: comments,
        clubId: post['ClubId'],
        instituteId: post['InstituteId'],
      ));
    });
    print("custom posts");
    return;
  }

  Future<void> addComment(
      ObjectId postId, String commentText, String userName) async {
    var coll = database.collection("posts");

    int index = postsList.indexWhere((post) => post.id == postId);
    CommentsModel comment = CommentsModel(postId: postId);
    comment.commentText = commentText;
    comment.user = userName;
    postsList[index].comments.add(comment);

    List<String> rawComments = [];
    postsList[index].comments.forEach((c) {
      String rawC;
      rawC = c.convertToRawComment();
      rawComments.add(rawC);
    });

    await coll.updateOne(
        where.eq('_id', postId), modify.set('Comments', rawComments));
  }

  Future<void> deleteComment(ObjectId postId, int index) async {
    var coll = database.collection("posts");

    int postIndex = postsList.indexWhere((post) => post.id == postId);

    postsList[postIndex].comments.removeAt(index);

    List<String> rawComments = [];
    postsList[postIndex].comments.forEach((c) {
      String rawC;
      rawC = c.convertToRawComment();
      rawComments.add(rawC);
    });

    await coll.updateOne(
        where.eq('_id', postId), modify.set('Comments', rawComments));

    return;
  }
}
