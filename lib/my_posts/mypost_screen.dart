import 'dart:math';

import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;
// import 'package:mongo_dart/mongo_dart.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../restart_controller.dart';
import 'models/post.dart';
import 'post_card.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({Key? key}) : super(key: key);

  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  var posts;
  var postscollection;
  var clubid;
  var clubposts;
  @override
  void initState() {
    () async {
      postscollection = RepositoryProvider.of<DatabaseAuthRepository>(context)
          .database
          .collection("posts");
      clubid =
          RepositoryProvider.of<DatabaseAuthRepository>(context).clubuser.id;
      clubposts =
          await postscollection.find(md.where.eq('ClubId', clubid)).toList();

      setState(() {
        posts = clubposts;
      });

      print(posts);
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Posts"),
        actions: [
          IconButton(
              onPressed: () {
                HotRestartController.performHotRestart(context);
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: (posts == null)
          ? Center(child: CircularProgressIndicator())
          : (posts.length == 0)
              ? Center(child: Text("You have no posts. Upload now"))
              : SmartRefresher(
                  enablePullDown: true,
                  controller: _refreshController,
                  onRefresh: () async {
                    setState(() {
                      posts = null;
                    });
                    clubposts = await postscollection
                        .find(md.where.eq('ClubId', clubid))
                        .toList();

                    setState(() {
                      posts = clubposts;
                    });
                    _refreshController.refreshCompleted();
                  },
                  child: ListView.builder(
                      itemBuilder: (_, index) {
                        return PostCard(
                          post: Post(
                              postid: posts[index]['_id'],
                              title: posts[index]['Title'],
                              description: posts[index]['Description']
                                  .substring(
                                      0,
                                      min(
                                          posts[index]['Description'].length
                                              as int,
                                          35)),
                              clubid: posts[index]['ClubId'],
                              imageUrl: posts[index]['ImageLink'],
                              date: posts[index]['Date']),
                        );
                      },
                      itemCount: posts.length,
                      physics: const AlwaysScrollableScrollPhysics()),
                ),
    );
  }
}
