import 'package:flutter/material.dart';
import 'login/login_screen.dart';
import 'databaseconnection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club Central',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        errorColor: Colors.red,
      ),
      home: RepositoryProvider(
        create: (context) => DatabaseAuthRepository(),   //Providing Database Repository All over the scope of the app
        child: LoginView(),
      ),
    );
  }
}
