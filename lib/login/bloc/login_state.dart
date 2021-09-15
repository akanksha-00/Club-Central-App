part of 'login_bloc.dart';

class LoginState {
  final String username;
  final String password;
  final FormSubmissionState presentstatus;
  LoginState(
      {required this.username, required this.password, required this.presentstatus});
  //! Validating the username and password
  //TODO: Discuss 
  bool get isValidUsername => username.length > 3;
  bool get isValidPassword => password.length > 6;
  LoginState copyWith(
      {String? username, String? password, FormSubmissionState? state}) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      presentstatus: state ?? this.presentstatus,
    );
  }
}

@immutable
abstract class FormSubmissionState {
  const FormSubmissionState();
}

class LoginInitial extends FormSubmissionState {
  const LoginInitial();
}

class LoginSubmitting extends FormSubmissionState {}

class LoginSuccess extends FormSubmissionState {}

class LoginFailed extends FormSubmissionState {
  final String exceptionmessage;
  LoginFailed(this.exceptionmessage);
}
