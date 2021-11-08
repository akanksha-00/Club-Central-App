import 'package:club_central/recruitment_application/models/sigs_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ClubsModel {
  final ObjectId id;
  final String username;
  final List<SigsModel> sigs;
  final String name;
  final bool isTechnical;
  final bool isRecruiting;

  ClubsModel(
      {required this.id,
      required this.username,
      required this.sigs,
      required this.name,
      required this.isTechnical,
      required this.isRecruiting});
}
