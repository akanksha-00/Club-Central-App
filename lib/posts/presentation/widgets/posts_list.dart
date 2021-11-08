import 'package:club_central/posts/models/post_model.dart';
import 'package:club_central/posts/presentation/bloc/posts_bloc.dart';
import 'package:club_central/posts/presentation/pages/view_posts_page.dart';
import 'package:club_central/posts/presentation/widgets/posts_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatelessWidget {
  final List<PostModel> posts;
  final int length;

  const PostsList({required this.posts, required this.length});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    PostsBloc postsBloc = BlocProvider.of<PostsBloc>(context);
    return Expanded(
        child: ListView(
      children: [
        ...[
          for (int i = 0; i < length; i++)
            BlocProvider.value(
              value: postsBloc,
              child: PostsCard(post: posts[i]),
            ),
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
                    builder: (newcontext1) => BlocProvider.value(
                      value: postsBloc,
                      child: ViewPosts(
                        posts: posts,
                      ),
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
