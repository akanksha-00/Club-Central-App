import 'package:club_central/posts/models/comment_model.dart';
import 'package:club_central/posts/presentation/bloc/posts_bloc.dart';
import 'package:club_central/posts/presentation/bloc/posts_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCard extends StatelessWidget {
  final CommentsModel comment;
  final String userName;
  final int index;

  const CommentCard(
      {Key? key,
      required this.comment,
      required this.userName,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostsBloc postsBloc = BlocProvider.of<PostsBloc>(context);
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    comment.user,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    comment.commentText,
                    style: TextStyle(fontSize: 16),
                  ),
                  if (comment.user == userName)
                    IconButton(
                      onPressed: () {
                        print('adding delete event');
                        postsBloc.add(DeleteComment(
                            postId: comment.postId, index: index));
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[800],
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
