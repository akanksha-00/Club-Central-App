part of 'changepwd_bloc.dart';

@immutable
abstract class ChangepwdEvent {}

class OldPwdChanged extends ChangepwdEvent {
  final String oldpassword;
  OldPwdChanged({required this.oldpassword});
}

class NewPwdChanged extends ChangepwdEvent {
  final String newpassword;
  NewPwdChanged({required this.newpassword});
}

class UpdateButtonClicked extends ChangepwdEvent {}
