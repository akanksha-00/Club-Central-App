part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}
class InitialScreen extends ProfileEvent {}
class EditProfileRequest extends ProfileEvent {}
class ChangePasswordRequest extends ProfileEvent {}
class LogoutRequest extends ProfileEvent {}
