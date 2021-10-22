import 'package:club_central/databaseconnection.dart';
import 'package:club_central/models/institute.dart';
import 'package:club_central/posts/presentation/bloc/posts_bloc.dart';
import 'package:club_central/posts/presentation/pages/posts_homepage.dart';
import 'package:club_central/posts/repository/posts_repository.dart';
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.5,
                    child: Column(
                      children: [
                        Text(
                          "Welcome, to Club Central!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image(
                    color: Colors.blue[900],
                    width: size.width * 0.3,
                    image: AssetImage("assets/icons/logo.png"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Top Posts",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 15,
          ),
          BlocProvider(
            create: (context) =>
                PostsBloc(postsRepository: PostsRepository(database: database)),
            child: PostsHomePage(
              institute: intitute,
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
        ],
      ),
    );
  }
}
