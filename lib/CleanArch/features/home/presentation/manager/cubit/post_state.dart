part of 'post_cubit.dart';

sealed class PostState {}

final class PostInitial extends PostState {}

class GetPostsLoadingState extends PostState {}
class GetPostsSuccessState extends PostState {
  }
class GetPostsErrorState extends PostState {
  final String errMessage;
  GetPostsErrorState({required this.errMessage});
}

class UserAddLikeSuccessState extends PostState {}
class UserAddLikeErrorState extends PostState {
   final String errMessage;
  UserAddLikeErrorState({required this.errMessage});
}

class UserAddCommentSuccessState extends PostState {}
class UserAddCommentErrorState extends PostState {
  final String errMessage;
  UserAddCommentErrorState({required this.errMessage});
}

class ChangeLikeButtonState extends PostState {}

class GetLikedUsersLoadingState extends PostState{}
class GetLikedUsersSuccessState extends PostState{
   static List<Map<String,dynamic>>likedUsers=[];
   static void setLikedUsers(List<Map<String,dynamic>>users){
    likedUsers=users;
   }
  GetLikedUsersSuccessState();
}

class GetPostCommentsLoadingState extends PostState{}
class GetPostCommentsSuccessState extends PostState{
   final int postIndex;
   static List<Map<String,dynamic>>postComments=[];
   static void setPostComments(List<Map<String,dynamic>>comments){
    postComments=comments;
   }
  GetPostCommentsSuccessState(this.postIndex);
}


class CreatePostLoadingState extends PostState {}
class CreatePostSuccessState extends PostState {}
class CreatePostErrorState extends PostState {}

class PickPostImageLoadingState extends PostState {}
class PickPostImageSuccessState extends PostState {}
class PickPostImageErrorState extends PostState {}

class UploadPostImageLoadingState extends PostState {}
class UploadPostImageSuccessState extends PostState {}
class UploadPostImageErrorState extends PostState {}
