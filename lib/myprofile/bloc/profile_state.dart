part of 'profile_bloc.dart';

class ProfileState {
  late final User user;
  late final Db db;
  final ButtonClicked button;
  ProfileState({required this.user, required this.db, required this.button});
  ProfileState copyWith(
      {String? username, String? password, ButtonClicked? button}) {
    return ProfileState(
      user: user ,
      db: db ,
      button: button ?? this.button,
    );
  }
}

@immutable
abstract class ButtonClicked {
  const ButtonClicked();
}

class NoButtonClicked extends ButtonClicked {
  const NoButtonClicked();
}

class EditProfileClick extends ButtonClicked {
  const EditProfileClick();
}

class ChangePasswordButtonClick extends ButtonClicked {
  const ChangePasswordButtonClick();
}

class LogoutButtonClick extends ButtonClicked {
  const LogoutButtonClick();
}
