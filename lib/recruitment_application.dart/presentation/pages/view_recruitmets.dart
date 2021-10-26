import 'package:club_central/recruitment_application.dart/models/clubs_model.dart';
import 'package:flutter/material.dart';

class ViewAllRecruitments extends StatelessWidget {
  final List<ClubsModel> clubs;
  const ViewAllRecruitments({required this.clubs});

  @override
  Widget build(BuildContext context) {
    print('rec');
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
    }
    return ListView(
      children: [
        Text('Recruitments'),
      ],
    );
  }
}
