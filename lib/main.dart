import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}
