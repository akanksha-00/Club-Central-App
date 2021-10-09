import 'package:flutter/material.dart';
import 'add_a_post/clubadminscreen.dart';
import 'login/login_screen.dart';
import 'login/nextpage.dart';
import 'myprofile/myprofile_screen.dart';
import 'repositories/session_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              DatabaseAuthRepository(), //Providing Database Repository All over the scope of the app
        ),
      ],
      child: MaterialApp(
        routes: {
          NextPage.routeName: (_) => NextPage(),
          MyProfilePage.routeName: (_) => MyProfilePage(),
          ClubAdminScreen.routeName: (_) => ClubAdminScreen(),
        },
        title: 'Club Central',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          errorColor: Colors.red,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
