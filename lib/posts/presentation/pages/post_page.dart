import 'package:club_central/posts/models/post_model.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  final PostModel post;
  const PostsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Post",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Image.network(
                post.imageLink,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                scale: 1.0,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'About:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                post.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ));
  }
}
