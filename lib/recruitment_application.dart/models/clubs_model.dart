import 'package:mongo_dart/mongo_dart.dart';

class ClubsModel {
  final ObjectId id;
  final String username;
  final List<ObjectId> sigs;
  final String name;
  final String isTechnical;
  final String isRecruiting;

  ClubsModel(
      {required this.id,
      required this.username,
      required this.sigs,
      required this.name,
      required this.isTechnical,
      required this.isRecruiting});
}
