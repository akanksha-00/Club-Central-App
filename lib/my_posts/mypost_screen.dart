import 'dart:math';

import 'package:club_central/login/login_screen.dart';
import 'package:club_central/login/nextpage.dart';
import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../main.dart';
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
  @override
  void initState() {
    () async {
      var postscollection =
          RepositoryProvider.of<DatabaseAuthRepository>(context)
              .database
              .collection("posts");
      var clubid =
          RepositoryProvider.of<DatabaseAuthRepository>(context).clubuser.id;
      var clubposts =
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
          ? CircularProgressIndicator()
          : (posts.length == 0)
              ? Center(child: Text("You have no posts. Upload now"))
              : ListView.builder(
                  itemBuilder: (_, index) {
                    return PostCard(
                      post: Post(
                          postid: posts[index]['_id'],
                          title: posts[index]['Title'],
                          description: posts[index]['Description'].substring(
                              0,
                              min(posts[index]['Description'].length as int,
                                  10)),
                          clubid: posts[index]['ClubId'],
                          imageUrl: posts[index]['ImageLink'],
                          date: posts[index]['Date']),
                    );
                  },
                  itemCount: posts.length,
                  physics: const AlwaysScrollableScrollPhysics()),
    );
  }
}
