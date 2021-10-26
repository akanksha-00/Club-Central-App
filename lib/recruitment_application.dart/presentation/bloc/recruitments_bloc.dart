import 'package:bloc/bloc.dart';
import 'package:club_central/recruitment_application.dart/models/clubs_model.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_event.dart';
import 'package:club_central/recruitment_application.dart/presentation/bloc/recruitments_state.dart';
import 'package:club_central/recruitment_application.dart/repository/recruitment_repository.dart';

class RecruitmentsBloc extends Bloc<RecruitmentsEvent, RecruitmentsState> {
  final RecruitmentRepository recruitmentRepository;
  RecruitmentsBloc({required this.recruitmentRepository})
      : super(InitialState());
  @override
  Stream<RecruitmentsState> mapEventToState(RecruitmentsEvent event) async* {
    if (event is GetRecruitments) {
      print('loading');
      yield LoadingState();
      print('loaded');
      try {
        List<ClubsModel> clubs =
            await recruitmentRepository.getRecruitingClubs(event.instituteId);
        
        yield LoadedState(clubs: clubs);
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }
}
