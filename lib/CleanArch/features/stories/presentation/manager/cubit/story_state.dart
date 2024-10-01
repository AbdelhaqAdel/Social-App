part of 'story_cubit.dart';

@immutable
sealed class StatusState {}

final class StatusInitial extends StatusState {}


class GetAllStatusLoadingState extends StatusState {}

class GetAllStatusSuccessState extends StatusState {
  final List<Map<String, dynamic>> statuses;

  GetAllStatusSuccessState(this.statuses);
}

class GetAllStatusErrorState extends StatusState {
  final String message;

  GetAllStatusErrorState(this.message);
}


class GetUserStatusLoadingState extends StatusState {}

class GetUserStatusSuccessState extends StatusState {
  final List<StatusModel> statuses;

  GetUserStatusSuccessState(this.statuses);
}

class GetUserStatusErrorState extends StatusState {
  final String message;

  GetUserStatusErrorState(this.message);
}


class AddStatusLoadingLoadingState extends StatusState {}

class AddStatusSuccessState extends StatusState {}

class AddStatusErrorState extends StatusState {
  final String message;

  AddStatusErrorState(this.message);
}
 
class ChangeStatusColorIndex extends StatusState {}