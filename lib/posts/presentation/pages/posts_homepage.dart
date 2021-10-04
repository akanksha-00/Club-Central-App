import 'package:club_central/posts/models/post_model.dart';
import 'package:club_central/posts/presentation/sample_posts.dart';
import 'package:club_central/posts/presentation/widgets/posts_card.dart';
import 'package:flutter/material.dart';

class PostsHomePage extends StatelessWidget {
  final List<PostModel> posts;
  const PostsHomePage({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return PostsCard(post: posts[index]);
        },
        itemCount: posts.length,
      ),
    );
  }
}
