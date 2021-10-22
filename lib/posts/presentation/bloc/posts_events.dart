import 'package:mongo_dart/mongo_dart.dart';

abstract class PostsEvents {}

class GetPostsEvent extends PostsEvents {
  final ObjectId instituteId;

  GetPostsEvent({required this.instituteId});
  
}
