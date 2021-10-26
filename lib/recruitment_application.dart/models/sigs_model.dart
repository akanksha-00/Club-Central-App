import 'package:mongo_dart/mongo_dart.dart';

class SigsModel {
  final ObjectId id;
  final ObjectId clubId;
  final String name;
  final List<int> rounds;

  SigsModel(
      {required this.id,
      required this.clubId,
      required this.name,
      required this.rounds});
}
