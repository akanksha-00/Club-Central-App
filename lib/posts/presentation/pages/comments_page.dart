import 'package:club_central/posts/models/comment_model.dart';
import 'package:club_central/posts/presentation/bloc/posts_bloc.dart';
import 'package:club_central/posts/presentation/bloc/posts_events.dart';
import 'package:club_central/posts/presentation/bloc/posts_states.dart';
import 'package:club_central/posts/presentation/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Comments extends StatelessWidget {
  final ObjectId postId;

  const Comments({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostsBloc postsBloc = BlocProvider.of<PostsBloc>(context);
    String userName = postsBloc.postsRepository.userName;
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return SpinKitSpinningLines(
            color: Colors.blue,
            lineWidth: 7,
          );
        } else if (state is LoadedState) {
          int index = state.posts.indexWhere((post) => post.id == postId);
          List<CommentsModel> comments = state.posts[index].comments;
          return Scaffold(
            appBar: AppBar(
              title: Text('Comments'),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 20.0),
              child: Container(
                child: ListView(
                  children: [
                    Text(
                      "Comments (" + comments.length.toString() + ")",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    ...[
                      for (int i = 0; i < comments.length; i++)
                        BlocProvider(
                          create: (context) => postsBloc,
                          child: CommentCard(
                            comment: comments[i],
                            userName: userName,
                            index: i,
                          ),
                        ),
                    ],
                    if (comments.length == 0) Text("No comments"),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                String commentText = "";
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 14),
                      child: Column(
                        children: [
                          Text(
                            'Write Comment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              commentText = text;
                            },
                            decoration: InputDecoration(
                                hintText: 'Comment...',
                                labelText: 'Comment',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {
                              print('adding comment');
                              postsBloc.add(AddComment(
                                  userName: userName,
                                  commentText: commentText,
                                  postId: postId));
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Text(
                                'Add Comment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            color: Colors.blue[900],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              label: Text(
                'Add Comment',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue[900],
              elevation: 0.0,
            ),
          );
        } else
          return Text('Error');
      },
    );
  }
}
