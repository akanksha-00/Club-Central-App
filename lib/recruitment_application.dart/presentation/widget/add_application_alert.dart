import 'package:club_central/recruitment_application.dart/models/sigs_model.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_bloc.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddApplicationAlert extends StatelessWidget {
  final SigsModel sig;
  const AddApplicationAlert({Key? key, required this.sig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecruitmentsBloc recruitmentsBloc =
        BlocProvider.of<RecruitmentsBloc>(context);
    return AlertDialog(
      title: Text('Apply to ' + sig.name + ' of ' + sig.clubName + '?'),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
        MaterialButton(
          onPressed: () {
            recruitmentsBloc.add(
                ApplyForRecruitmentEvent(sigId: sig.id, clubId: sig.clubId));
            Navigator.pop(context);
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
