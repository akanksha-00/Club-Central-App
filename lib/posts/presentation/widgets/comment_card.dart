import 'package:club_central/posts/models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final CommentsModel comment;
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(width: 8.0,),
                  Text(comment.user,style: TextStyle(fontSize: 18),),
                ],
              ),
              SizedBox(height: 12.0,),
              Text(comment.commentText,style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
