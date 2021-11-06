import 'package:club_central/recruitment_application.dart/models/clubs_model.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_bloc.dart';
import 'package:club_central/recruitment_application.dart/presentation/pages/sigs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitmentsCard extends StatelessWidget {
  final ClubsModel club;
  const RecruitmentsCard({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecruitmentsBloc recruitmentsBloc =
        BlocProvider.of<RecruitmentsBloc>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/icons/logo.png"),
          ),
          trailing: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (buttoncontext) => BlocProvider(
                        create: (newcontext) => recruitmentsBloc,
                        child: SigsPage(
                          clubId: club.id,
                        ),
                      )));
            },
            child: Text(
              'View',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue[900],
          ),
          title: Text(club.name),
        ),
      ),
    );
  }
}
