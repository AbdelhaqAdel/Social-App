part of '../../../CleanArch/core/cubit/app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class ChangeCurrentIndexState extends AppState {}
class AddPostState extends AppState {}

class GetNotifyLoadingState extends AppState {}
class GetNotifySuccessState extends AppState {}
class GetNotifyErrorState extends AppState {}

class DeleteNotifyLoadingState extends AppState {}
class DeleteNotifySuccessState extends AppState {}
class DeleteNotifyErrorState extends AppState {}



