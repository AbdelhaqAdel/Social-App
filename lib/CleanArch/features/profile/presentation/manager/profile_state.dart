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

class ImageProfilePickedLoadingState extends ProfileState {}
class ImageProfilePickedSuccessState extends ProfileState {}
class ImageProfilePickedErrorState extends ProfileState {}

class ImageUploadLoadingState extends ProfileState {}
class ImageUploadSuccessState extends ProfileState {}
class ImageUploadErrorState extends ProfileState {}

class ImageCoverPickedLoadingState extends ProfileState {}
class ImageCoverPickedSuccessState extends ProfileState {}
class ImageCoverPickedErrorState extends ProfileState {}

// class ImageCoverUploadLoadingState extends ProfileState {}
// class ImageCoverUploadSuccessState extends ProfileState {}
// class ImageCoverUploadErrorState extends ProfileState {}

class UserUpdateLoadingState extends ProfileState {}
class UserUpdateSuccessState extends ProfileState {}
class UserUpdateErrorState extends ProfileState {}



// part of 'profile_cubit.dart';

// abstract class ImageState {}

// class ImageInitial extends ImageState {}

// class ImagePickingLoading extends ImageState {}

// class ImageProfilePickedSuccess extends ImageState {}

// class ImageCoverPickedSuccess extends ImageState {}

// class ImagePickingError extends ImageState {}

// class ImageUploadingLoading extends ImageState {}

// class ImageUploadSuccess extends ImageState {}

// class ImageUploadError extends ImageState {}

