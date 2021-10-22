import 'package:mongo_dart/mongo_dart.dart';

class NewPost {
  String title;
  ObjectId clubid;
  String description;
  DateTime date;
  ObjectId instituteId;
  String imageUrl;
  NewPost(
      {required this.title,
      required this.clubid,
      required this.description,
      required this.date,
      required this.instituteId,
      required this.imageUrl});
}
