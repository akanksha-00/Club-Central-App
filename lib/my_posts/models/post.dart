import 'package:mongo_dart/mongo_dart.dart';

class Post {
  ObjectId postid;
  String title;
  ObjectId clubid;
  String description;
  DateTime date;
  String imageUrl;
  Post(
      {required this.postid,
      required this.title,
      required this.clubid,
      required this.description,
      required this.date,
      required this.imageUrl});
}
