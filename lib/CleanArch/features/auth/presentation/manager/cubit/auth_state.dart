part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class IsObsecurePassState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {
  final String uid;
  RegisterSuccessState({required this.uid});
}
class RegisterErrorState extends AuthState {
    final String errMessage;
  RegisterErrorState({required this.errMessage});
}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
    final String uid;
  LoginSuccessState({required this.uid});
}
class LoginErrorState extends AuthState {
  final String errMessage;
  LoginErrorState({required this.errMessage});
}

class GetUserLoadingState extends AuthState {}
class GetUserSuccessState extends AuthState {}
class GetUserErrorState extends AuthState {
}