import 'package:mongo_dart/mongo_dart.dart';

class NewPost {
  String title;
  ObjectId clubid;
  String description;
  DateTime date;
  String imageUrl;
  NewPost(
      {required this.title,
      required this.clubid,
      required this.description,
      required this.date,
      required this.imageUrl});
}
