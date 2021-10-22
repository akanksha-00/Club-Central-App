part of 'changepwd_bloc.dart';

class ChangepwdState {
  final String oldpassword;
  final String newpassword;
  final UpdateStatus status;
  ChangepwdState(
      {required this.oldpassword,
      required this.newpassword,
      required this.status});
  bool get isValidOldPassword => oldpassword.length > 6;
  bool get isValidNewPassword => newpassword.length > 6;
  ChangepwdState copyWith(
      {String? oldpassword, String? newpassword, UpdateStatus? status}) {
    return ChangepwdState(
      oldpassword: oldpassword ?? this.oldpassword,
      newpassword: newpassword ?? this.newpassword,
      status: status ?? this.status,
    );
  }
}

@immutable
abstract class UpdateStatus {
  const UpdateStatus();
}

class InitialStatus extends UpdateStatus {
  const InitialStatus();
}

class Updating extends UpdateStatus {}

class UpdateSuccess extends UpdateStatus {}

class UpdateFail extends UpdateStatus {
  final String message;
  UpdateFail(this.message);
}
