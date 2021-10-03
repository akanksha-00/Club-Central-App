import 'package:bloc/bloc.dart';
import 'package:club_central/models/institute.dart';
import 'package:club_central/models/user.dart';
import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User user;
  Db db;
  ProfileBloc({required this.user, required this.db})
      : super(ProfileState(user: user, db: db, button: NoButtonClicked()));
  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    print(db);
    if (event is EditProfileRequest) {
      yield state.copyWith(button: EditProfileClick());
    } else if (event is ChangePasswordRequest) {
      yield state.copyWith(button: ChangePasswordButtonClick());
    } else if (event is LogoutRequest) {
      yield state.copyWith(button: LogoutButtonClick());
    }
  }
}
