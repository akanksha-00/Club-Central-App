import 'package:club_central/recruitment_application.dart/models/sigs_model.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_bloc.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_state.dart';
import 'package:club_central/recruitment_application.dart/presentation/widget/sigs_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SigsPage extends StatelessWidget {
  final ObjectId clubId;
  const SigsPage({required this.clubId});

  @override
  Widget build(BuildContext context) {
    RecruitmentsBloc recruitmentsBloc =
        BlocProvider.of<RecruitmentsBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Sigs'),
        ),
        body: BlocBuilder<RecruitmentsBloc, RecruitmentsState>(
          builder: (context, state) {
            print('updating sigs list');
            List<SigsModel> sigs = recruitmentsBloc.recruitmentRepository.clubs
                .firstWhere((club) => club.id == clubId)
                .sigs;
            return ListView.builder(
              itemBuilder: (context, index) {
                print(
                    sigs[index].name + " " + sigs[index].isApplied.toString());
                return SigsCard(sig: sigs[index]);
              },
              itemCount: sigs.length,
            );
          },
        ));
  }
}
