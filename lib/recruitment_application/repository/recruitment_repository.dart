
import 'package:club_central/recruitment_application/models/clubs_model.dart';
import 'package:club_central/recruitment_application/models/sigs_model.dart';
import 'package:logger/logger.dart';
import 'package:mongo_dart/mongo_dart.dart';

class RecruitmentRepository {
  final Db database;
  final String username;

  RecruitmentRepository({required this.database, required this.username});

  List<ClubsModel> clubs = <ClubsModel>[];

  Future<void> getRecruitingClubs(ObjectId instituteId) async {
    var globalSchema = database.collection("globalschema");
    var superAdmin = await globalSchema
        .findOne({'instituteName': instituteId, 'isSuperAdmin': true});

    if (superAdmin != null) print(superAdmin['username']);

    var clubsColl = database.collection("club");
    var sigsColl = database.collection('sigs');
    var applicationsColl = database.collection('applications');

    var rawRecClubs = await clubsColl.find(
        {'username': superAdmin!['username'], 'isRecruiting': true}).toList();

    rawRecClubs.forEach((club) {
      List<ObjectId> sigsIdList = List<ObjectId>.from(club['SIGS']);
      List<SigsModel> sigs = [];

      sigsIdList.forEach((sigId) async {
        var sig = await sigsColl.findOne({'_id': sigId});

        bool isApplied = (await applicationsColl.find({
                  'username': username,
                  'sig_id': sigId,
                  'club_id': club['_id']
                }).length) ==
                0
            ? false
            : true;

        sigs.add(SigsModel(
          id: sig!['_id'],
          clubId: sig['club_id'],
          name: sig['name'],
          clubName: club['name'],
          rounds: List<Object>.from(sig['rounds']),
          isApplied: isApplied,
        ));
      });

      if (club['isRecruiting'] == true) {
        clubs.add(ClubsModel(
            id: club['_id'],
            username: club['username'],
            sigs: sigs,
            name: club['name'],
            isTechnical: club['isTechnical'],
            isRecruiting: club['isRecruiting']));
      }
    });

    return;
  }

  Future<void> applyToClubSig(
    ObjectId clubId,
    ObjectId sigId,
  ) async {
    var applicationsColl = database.collection('applications');
    int check = (await applicationsColl.find({
              'username': username,
              'sig_id': sigId,
              'club_id': clubId
            }).length) ==
            1
        ? 1
        : 0;
    if (check == 0) {
      var application = {
        '_id': new ObjectId(),
        'username': username,
        'club_id': clubId,
        'sig_id': sigId,
        'status': {'round_no': 1, 'status': 1}
      };
      await database.collection('applications').insert(application);
      int indexClub = clubs.indexWhere((club) => club.id == clubId);
      if (indexClub >= 0) {
        int indexSig =
            clubs[indexClub].sigs.indexWhere((sig) => sig.id == sigId);
        if (indexSig >= 0) {
          clubs[indexClub].sigs[indexSig].isApplied = true;
        }
      }
      print("apply to sigs");
      clubs[indexClub].sigs.forEach((sig) {
        Logger().d(sig.name + " " + sig.isApplied.toString());
      });
    }
  }
}
