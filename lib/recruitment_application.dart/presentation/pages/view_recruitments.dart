import 'package:club_central/recruitment_application.dart/models/clubs_model.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_bloc.dart';
import 'package:club_central/recruitment_application.dart/presentation/widget/clubs_recruitment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllRecruitments extends StatelessWidget {
  final List<ClubsModel> clubs;
  const ViewAllRecruitments({required this.clubs});

  @override
  Widget build(BuildContext context) {
    RecruitmentsBloc recruitmentsBloc =
        BlocProvider.of<RecruitmentsBloc>(context);
    if (clubs.length == 0) {
      return Center(
        child: Text(
          'No clubs are recruiting!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return BlocProvider(
              create: (context) => recruitmentsBloc,
              child: RecruitmentsCard(club: clubs[index]),
            );
          },
          itemCount: clubs.length,
        ),
      );
  }
}
