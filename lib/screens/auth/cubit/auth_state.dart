part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserModel userModel;

  AuthSuccessState({required this.userModel});
}

class RegisterSuccessState extends AuthState {
  final UserModel userModel;

  RegisterSuccessState({required this.userModel});
}

class LoginSuccessState extends AuthState {
  final UserModel userModel;

  LoginSuccessState({required this.userModel});
}

class AuthFailedState extends AuthState {
  final String error;
  AuthFailedState(this.error);
}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState(this.error);
}

class ErrorUserDataState extends AuthState {}

class ChangePasswordVisibilityState extends AuthState {}

class CheckConnectionState extends AuthState {}

class ImagePickerState extends AuthState {}
