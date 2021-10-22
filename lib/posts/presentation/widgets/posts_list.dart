import 'package:club_central/posts/models/post_model.dart';
import 'package:club_central/posts/presentation/pages/view_posts_page.dart';
import 'package:club_central/posts/presentation/widgets/posts_card.dart';
import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {
  final List<PostModel> posts;

  const PostsList({required this.posts});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
        child: ListView(
      children: [
        ...[
          for (int i = 0; i < posts.length; i++) PostsCard(post: posts[i]),
        ],
        SizedBox(
          height: 12.0,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width * 0.4,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPosts(
                      posts: posts,
                    ),
                  ),
                );
              },
              color: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11.0, 10.0, 11.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
