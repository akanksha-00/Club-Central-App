import 'package:bloc/bloc.dart';
import 'package:club_central/recruitment_application/presentation/bloc/recruitments_event.dart';
import 'package:club_central/recruitment_application/presentation/bloc/recruitments_state.dart';
import 'package:club_central/recruitment_application/repository/recruitment_repository.dart';


class RecruitmentsBloc extends Bloc<RecruitmentsEvent, RecruitmentsState> {
  final RecruitmentRepository recruitmentRepository;
  RecruitmentsBloc({required this.recruitmentRepository})
      : super(InitialState());
  @override
  Stream<RecruitmentsState> mapEventToState(RecruitmentsEvent event) async* {
    if (event is GetRecruitmentsEvent) {
      print('loading');
      yield LoadingState();
      print('loaded');
      try {
        await recruitmentRepository.getRecruitingClubs(event.instituteId);
        yield LoadedState(clubs: recruitmentRepository.clubs);
      } catch (e) {
        print(e.toString());
      }
    } else if (event is ApplyForRecruitmentEvent) {
      yield AddingApplicationState();
      try {
        await recruitmentRepository.applyToClubSig(event.clubId, event.sigId);
        yield AddedApplicationState();
        yield LoadedState(clubs: recruitmentRepository.clubs);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
