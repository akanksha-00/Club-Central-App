import 'dart:convert';

import 'package:club_central/posts/presentation/pages/comments_page.dart';
import 'package:club_central/posts/models/post_model.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  final PostModel post;
  const PostsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text(
            "Post",
          ),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(Base64Decoder().convert(post.imageLink)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.45),
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 20, 25),
                  child: Column(
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        height: 8.0,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        post.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: size.width * 0.45,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Comments(comments: post.comments),
                              ),
                            );
                          },
                          color: Colors.red[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                11.0, 10.0, 11.0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.comment,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Comments",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
