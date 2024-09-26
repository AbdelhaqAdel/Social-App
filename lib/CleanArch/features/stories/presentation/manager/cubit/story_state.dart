part of 'story_cubit.dart';

@immutable
sealed class StatusState {}

final class StatusInitial extends StatusState {}


class GetAllStatusLoadingState extends StatusState {}

class GetAllStatusSuccessState extends StatusState {
  final List<StatusModel> statuses;

  GetAllStatusSuccessState(this.statuses);
}

class GetAllStatusErrorState extends StatusState {
  final String message;

  GetAllStatusErrorState(this.message);
}


class AddStatusLoadingLoadingState extends StatusState {}

class AddStatusSuccessState extends StatusState {}

class AddStatusErrorState extends StatusState {
  final String message;

  AddStatusErrorState(this.message);
}