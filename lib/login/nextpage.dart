import 'package:club_central/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:club_central/myprofile/myprofile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//! DUMMY PAGE TO GO TO INCASE LOGIN IS SUCCESSFUL
class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);
  static const String routeName = "/homepage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Home",
        ),
      ),
      body: HomePage(),
    );
  }
}
