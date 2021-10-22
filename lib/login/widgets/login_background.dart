import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  Widget formwidget;
  LoginBackground({required this.formwidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.blue,
          child: Align(
            alignment: Alignment(0.0, -0.5),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width * 0.50,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/icons/logo.png",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  color: Color(0xFFF3F3F5),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(50.0),
                  ),
                ),
                child: formwidget))
      ],
    );
  }
}
