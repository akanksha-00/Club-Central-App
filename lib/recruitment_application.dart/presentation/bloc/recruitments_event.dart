import 'package:mongo_dart/mongo_dart.dart';

abstract class RecruitmentsEvent {}

class GetRecruitments extends RecruitmentsEvent {
  final ObjectId instituteId;

  GetRecruitments({required this.instituteId});
}
