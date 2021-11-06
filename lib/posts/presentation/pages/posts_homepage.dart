import 'package:club_central/models/institute.dart';
import 'package:club_central/posts/presentation/bloc/posts_bloc.dart';
import 'package:club_central/posts/presentation/bloc/posts_events.dart';
import 'package:club_central/posts/presentation/bloc/posts_states.dart';
import 'package:club_central/posts/presentation/pages/view_posts_page.dart';
import 'package:club_central/posts/presentation/widgets/no_posts.dart';
import 'package:club_central/posts/presentation/widgets/posts_list.dart';
import 'package:club_central/posts/repository/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PostsHomePage extends StatelessWidget {
  final Institute institute;
  const PostsHomePage({required this.institute});

  @override
  Widget build(BuildContext context) {
    PostsBloc postsBloc = BlocProvider.of<PostsBloc>(context);

    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is InitialState) {
          postsBloc.add(GetPostsEvent(instituteId: institute.id));
        }
        if (state is LoadingState) {
          return SpinKitSpinningLines(
            color: Colors.blue,
            lineWidth: 7,
          );
        } else if (state is LoadedState) {
          return PostsList(
            posts: state.posts,
            length: 3,
          );
        } else if (state is EmptyState) {
          return NoPosts();
        } else if (state is ErrorState) {
          return Center(child: Text("Error"));
        }
        return Container();
      },
    );
  }
}
