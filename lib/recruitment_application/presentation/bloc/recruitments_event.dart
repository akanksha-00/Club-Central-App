import 'package:mongo_dart/mongo_dart.dart';

abstract class RecruitmentsEvent {}

class GetRecruitmentsEvent extends RecruitmentsEvent {
  final ObjectId instituteId;

  GetRecruitmentsEvent({required this.instituteId});
}

class ApplyForRecruitmentEvent extends RecruitmentsEvent {
  final ObjectId sigId;
  final ObjectId clubId;

  ApplyForRecruitmentEvent({required this.sigId, required this.clubId});
}
