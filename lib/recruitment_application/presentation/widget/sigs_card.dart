
import 'package:club_central/recruitment_application/models/sigs_model.dart';
import 'package:club_central/recruitment_application/presentation/bloc/recruitments_bloc.dart';
import 'package:club_central/recruitment_application/presentation/bloc/recruitments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_application_alert.dart';

class SigsCard extends StatelessWidget {
  final SigsModel sig;
  const SigsCard({Key? key, required this.sig}) : super(key: key);

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
          trailing: sig.isApplied == false
              ? MaterialButton(
                  color: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          if (recruitmentsBloc.state
                              is AddingApplicationState) {
                            return CircularProgressIndicator();
                          } else if (recruitmentsBloc.state
                              is AddedApplicationState) {
                            return Container();
                          }
                          return BlocProvider(
                            create: (context) => recruitmentsBloc,
                            child: AddApplicationAlert(sig: sig),
                          );
                        });
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  ))
              : Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Applied',
                        style: TextStyle(color: Colors.blue[900], fontSize: 15),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
          title: Text(sig.name),
        ),
      ),
    );
  }
}
