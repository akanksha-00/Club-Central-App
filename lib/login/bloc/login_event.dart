part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class UsernameChanged extends LoginEvent {
  final String username;
  UsernameChanged({required this.username});
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {
}