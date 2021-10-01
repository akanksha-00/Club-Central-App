import 'package:club_central/posts/models/post_model.dart';
import 'package:club_central/posts/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';

class PostsCard extends StatelessWidget {
  final PostModel post;

  const PostsCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostsPage(
                post: post,
              ),
            ),
          );
        },
        title: Text(post.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(post.imageLink),
          radius: 20.0,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
