part of 'profile_cubit.dart';

sealed class ProfileState {}

final class AuthInitial extends ProfileState {}

class GetUserDataLoadingState extends ProfileState {}
class GetUserDataSuccessState extends ProfileState {
   final UserModel userData;
   GetUserDataSuccessState({required this.userData});
}
class GetUserDataErrorState extends ProfileState {
   final String errMessage;
  GetUserDataErrorState({required this.errMessage});
}