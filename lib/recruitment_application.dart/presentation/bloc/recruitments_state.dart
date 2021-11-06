import 'package:club_central/recruitment_application.dart/models/clubs_model.dart';
import 'package:club_central/recruitment_application.dart/models/sigs_model.dart';

abstract class RecruitmentsState {}

class InitialState extends RecruitmentsState {}

class LoadingState extends RecruitmentsState {}

class LoadedState extends RecruitmentsState {
  final List<ClubsModel> clubs;

  LoadedState({required this.clubs});
}

class AddingApplicationState extends RecruitmentsState {}

class AddedApplicationState extends RecruitmentsState {}

class ErrorState extends RecruitmentsState {}
