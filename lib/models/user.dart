import 'package:mongo_dart/mongo_dart.dart';

import 'institute.dart';

class User {
  ObjectId id;
  String username;
  String name = "";
  bool isAdmin=false;
  bool isSuperAdmin=false;
  Institute institute;
  User(
      {required this.id,
      required this.username,
      required this.isAdmin,
      required this.isSuperAdmin,
      required this.institute});
}
