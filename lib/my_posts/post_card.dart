import 'dart:convert';

import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/post.dart';
import 'mypost_screen.dart';

class PostCard extends StatelessWidget {
  Post post;
  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            child: Image.memory(Base64Decoder().convert(post.imageUrl)),
            width: 50,
            height: 50),
      ),
      subtitle: Text(post.description),
      tileColor: Colors.white30,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${post.title}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(
            "${RepositoryProvider.of<DatabaseAuthRepository>(context).presentInstitute.name}",
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
      trailing: IconButton(
          onPressed: () async {
            var database =
                RepositoryProvider.of<DatabaseAuthRepository>(context).database;
            var coll = database.collection("posts");
            await coll.deleteOne({"_id": post.postid});
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyPostsScreen(),
              ),
            );
          },
          icon: Icon(Icons.delete, color: Theme.of(context).errorColor)),
    );
  }
}
