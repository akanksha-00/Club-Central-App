import 'package:mongo_dart/mongo_dart.dart';

class SigsModel {
  final ObjectId id;
  final ObjectId clubId;
  final String name;
  final clubName;
  final List<Object> rounds;
  bool isApplied;

  SigsModel({
    required this.id,
    required this.clubId,
    required this.name,
    required this.clubName,
    required this.rounds,
    required this.isApplied,
  });
}
