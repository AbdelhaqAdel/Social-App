part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginPasswordState extends LoginState {}

class LoginIsloadingStateState extends LoginState {}
