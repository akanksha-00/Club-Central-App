import 'package:club_central/posts/models/comment_model.dart';
import 'package:club_central/posts/presentation/widgets/comment_card.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final List<CommentsModel> comments;

  const Comments({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 18,
              ),
              ...[
                for (int i = 0; i < comments.length; i++)
                  CommentCard(comment: comments[i]),
              ],
              if (comments.length == 0) Text("No comments"),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   color: Colors.amberAccent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: width * 0.8,
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             hintText: 'Add Comment...',
//                             labelText: 'Add Comment...',
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(width: 2)),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.send,
//                             size: 26,
//                           )),
//                     ],
//                   ),
//                 ),
//               ),