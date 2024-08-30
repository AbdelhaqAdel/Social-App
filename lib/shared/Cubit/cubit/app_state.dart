part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class LoginPasswordState extends AppState {}
class RegisterIsloadingStateState extends AppState {}

class changeBottoomSheetState extends AppState {}

class LoginIsloadingStateState extends AppState {}
class ChangeCurrentIndexState extends AppState {}
class AddPostIndexState extends AppState {}

/*----------------------------------------------*/
class shopRegisterLoadingState extends AppState {}

class shopRegisterSuccessState extends AppState {
  final String uid;
  shopRegisterSuccessState(this.uid);
}
class shopRegisterErrorState extends AppState {
  shopRegisterErrorState();
}
/*----------------------------------------------*/
class shopAddUserLoadingState extends AppState {}

class shopAddUserSuccessState extends AppState {
  //final UserRegisterModel userModel;

  final String uid;
  shopAddUserSuccessState(this.uid);
}
class shopAddUserErrorState extends AppState {
  shopAddUserErrorState();
}
/*-------------------------LOGIN------------------*/
class shopLoginLoadingState extends AppState {}

class shopLoginSuccessState extends AppState {
  //final UserRegisterModel userModel;
  final String uid;
  shopLoginSuccessState(this.uid);
}
class shopLoginErrorState extends AppState {
  shopLoginErrorState();
}

/*---------------------Get user Data-----------*/
class shopGetUserLoadingState extends AppState {}

class shopGetUserSuccessState extends AppState {
  //final UserRegisterModel userModel;
  // final String uid;
  shopGetUserSuccessState();
}
class shopGetUserErrorState extends AppState {
  shopGetUserErrorState();
}

class ImageProfilePickedSuccessState extends AppState {}
class ImageProfilePickedErrorState extends AppState {}

class ImageUploadSuccessState extends AppState {}
class ImageUploadErrorState extends AppState {}

class UserUpdateLoagingState extends AppState {}
class UserUpdateErrorState extends AppState {}

class ImageCoverPickedSuccessState extends AppState {}
class ImageCoverPickedErrorState extends AppState {}

class ImageCoverUploadSuccessState extends AppState {}
class ImageCoverUploadErrorState extends AppState {}

class UserCoverUpdateLoagingState extends AppState {}
class UserCoverUpdateErrorState extends AppState {}

/*-------------------post---------------*/
class ImagePostPickedSuccessState extends AppState {}
class ImagePostPickedErrorState extends AppState {}

class CreatePostSuccessState extends AppState {}
class CreatePostErrorState extends AppState {}

class ImagePostUploadLoadingState extends AppState {}
class ImagePostUploadSuccessState extends AppState {}
class ImagePostUploadErrorState extends AppState {}


class GetPostLoadingState extends AppState {}
class GetPostSuccessState extends AppState {}
class GetPostErrorState extends AppState {}


class GetPostDataLoadingState extends AppState {}
class GetPostDataSuccessState extends AppState {}
class GetPostDataErrorState extends AppState {}


class UserAddPostLikeSuccessState extends AppState {}
class UserAddPostLikeErrorState extends AppState {}


class GetPostsLikesLoadingState extends AppState {}
class GetPostsLikesSuccessState extends AppState {}
class GetPostsLikesErrorState extends AppState {}

class GetIsLikedSuccessState extends AppState {}
class GetIsLikedErrorState extends AppState {}

class ImageStatusPickedSuccessState extends AppState {}
class ImageStatusPickedErrorState extends AppState {}

class CreateStatusSuccessState extends AppState {}
class CreateStatusErrorState extends AppState {}

class ImageStatusUploadLoadingState extends AppState {}
class ImageStatusUploadSuccessState extends AppState {}
class ImageStatusUploadErrorState extends AppState {}


class ChangeStatusColorIndex extends AppState {}


class GetStatusLoadingState extends AppState {}
class GetStatusSuccessState extends AppState {}
class GetStatusErrorState extends AppState {}

class GetUserAddStatusLoadingState extends AppState {}
class GetUserAddStatusSuccessState extends AppState {
  final  List<StatusModel>status;
  GetUserAddStatusSuccessState({required this.status});
}
class GetUserAddStatusErrorState extends AppState {}


class AddChatLoadingState extends AppState {}
class AddChatSuccessState extends AppState {}
class AddChatErrorState extends AppState {}
class ChangeChatIndexState extends AppState {}


class GetAllMessagesLoadingState extends AppState {}
class GetAllMessagesSuccessState extends AppState {}
class GetAllMessagesErrorState extends AppState {}


class GetUserLoadingState extends AppState {}
class GetUserSuccessState extends AppState {}
class GetUserErrorState extends AppState {}



class SendNotifyLoadingState extends AppState {}
class SendNotifySuccessState extends AppState {}
class SendNotifyErrorState extends AppState {}

class OnMessageSendLoadingState extends AppState {}

class AddnewnotifyToHiveLoadingState extends AppState{}
class AddnewNotifyToHiveSuccessState extends AppState{}
class AddnewNotifyToHiveErrorState extends AppState{}


