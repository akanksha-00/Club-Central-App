import 'package:club_central/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

//! DUMMY PAGE TO GO TO INCASE LOGIN IS SUCCESSFUL
class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

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
