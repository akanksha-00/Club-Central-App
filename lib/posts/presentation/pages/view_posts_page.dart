import 'package:club_central/posts/models/post_model.dart';
import 'package:club_central/posts/presentation/widgets/posts_card.dart';
import 'package:flutter/material.dart';

class ViewPosts extends StatelessWidget {
  final List<PostModel> posts;
  const ViewPosts({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 20.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return PostsCard(post: posts[index]);
            },
            itemCount: posts.length,
          ),
        ),
      ),
    );
  }
}
