import 'package:club_central/myprofile/myprofile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//! DUMMY PAGE TO GO TO INCASE LOGIN IS SUCCESSFUL
class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);
  static const String routeName = "/homepage";

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:'try',
      child: Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MyProfilePage.routeName);
          },
          icon: Icon(Icons.person),
          color: Color(0xff2196f3),
        ),
      ),
    );
  }
}
