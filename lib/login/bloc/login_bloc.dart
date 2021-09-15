import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import '../../databaseconnection.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseAuthRepository authRepo;
  //* Intial state of the login screen is LoginInitial
  
  LoginBloc({required this.authRepo})
      : super(LoginState(username: "", presentstatus: LoginInitial(), password: ''));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(state: LoginSubmitting());
      try {
        bool successful = await authRepo.login(state.username, state.password);
        if (successful == true) {
          yield state.copyWith(state: LoginSuccess());
        } 

        print("Login = {$successful}");
      } catch (e) {
        yield state.copyWith(state: LoginFailed(e.toString()));
        yield state.copyWith(state: LoginInitial());
      }
    }
  }
}
