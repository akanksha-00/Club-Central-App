import 'package:club_central/posts/models/comment_model.dart';
import 'package:club_central/posts/models/post_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class PostsRepository {
  final Db database;

  PostsRepository({required this.database});

  Future<List<PostModel>?> getPosts(ObjectId instituteId) async {
    List<PostModel> postsList = <PostModel>[];
    var coll = database.collection("posts");
    var rawPosts = await coll.find({'InstituteId': instituteId}).toList();
    print("rawposts obtained");
    rawPosts.forEach((post) {
      List<String> rawComments = List<String>.from(post["Comments"]);
      List<CommentsModel> comments = <CommentsModel>[];
      rawComments.forEach((rawComment) {
        CommentsModel c = CommentsModel();
        c.getCommentFromRawComment(rawComment);
        comments.add(c);
      });
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
    return postsList;
  }
}
