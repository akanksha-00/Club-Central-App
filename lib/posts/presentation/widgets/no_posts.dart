import 'package:flutter/material.dart';

class NoPosts extends StatelessWidget {
  const NoPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("No Posts to show!"),
      ),
    );
  }
}
