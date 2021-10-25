import 'package:club_central/application_status/application_status.dart';
import 'package:club_central/models/institute.dart';
import 'package:club_central/posts/presentation/bloc/posts_bloc.dart';
import 'package:club_central/posts/presentation/pages/posts_homepage.dart';
import 'package:club_central/posts/repository/posts_repository.dart';
import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var database =
        RepositoryProvider.of<DatabaseAuthRepository>(context).database;
    Institute intitute =
        RepositoryProvider.of<DatabaseAuthRepository>(context).presentInstitute;

    return Scaffold(
      body: ApplicationStatus(),
    );
  }
}
