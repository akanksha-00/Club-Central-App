import 'package:mongo_dart/mongo_dart.dart';

class ClubUser {
  ObjectId id;
  String name;
  ClubUser({required this.id, required this.name});
}
