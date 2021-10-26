import 'package:club_central/recruitment_application.dart/models/clubs_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class RecruitmentRepository {
  final Db database;

  RecruitmentRepository({required this.database});

  Future<List<ClubsModel>> getRecruitingClubs(ObjectId instituteId) async {
    List<ClubsModel> clubs = <ClubsModel>[];
    var coll = database.collection("club");
    var rawRecClubs = await coll.find({'InstituteId': instituteId}).toList();
    print('got raw recruiting clubs');
    rawRecClubs.forEach((club) {
      List<ObjectId> sigs = List<ObjectId>.from(club['SIGS']);
      clubs.add(ClubsModel(
          id: club['_id'],
          username: club['username'],
          sigs: sigs,
          name: club['name'],
          isTechnical: club['isTechnical'],
          isRecruiting: club['isRecruiting']));
      print('created club');
    });
    print('returning recruiting clubs');
    return clubs;
  }
}
