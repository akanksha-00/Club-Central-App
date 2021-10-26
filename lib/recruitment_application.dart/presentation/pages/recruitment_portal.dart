import 'package:club_central/models/institute.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_bloc.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_event.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_state.dart';
import 'package:club_central/recruitment_application.dart/presentation/pages/view_recruitmets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitmentsPortalPage extends StatelessWidget {
  final Institute institute;
  const RecruitmentsPortalPage({Key? key, required this.institute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecruitmentsBloc recruitmentsBloc =
        BlocProvider.of<RecruitmentsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recruitments Portal'),
      ),
      body: BlocBuilder<RecruitmentsBloc, RecruitmentsState>(
        builder: (context, state) {
          if (state is InitialState) {
            recruitmentsBloc.add(GetRecruitments(instituteId: institute.id));
          } else if (state is LoadingState) {
            print('i am loading');
            CircularProgressIndicator();
          } else if (state is LoadedState) {
            print('loaded rec');
            ViewAllRecruitments(
              clubs: state.clubs,
            );
          } else if (state is ErrorState) {
            return Center(child: Text('Error occurred'));
          }
          return Container();
        },
      ),
    );
  }
}
