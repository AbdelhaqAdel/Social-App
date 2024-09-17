part of 'post_cubit.dart';

sealed class PostState {}

final class PostInitial extends PostState {}

class GetPostsLoadingState extends PostState {}
class GetPostsSuccessState extends PostState {
  static List<PostModel>allPosts=[];
   static void setAllPosts(List<PostModel>posts){
    allPosts=posts;
   }
   
  final List<PostModel>posts;
 
  GetPostsSuccessState({
    required this.posts,
  });
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
    final List<Map<String,dynamic>>likedUsers;
  GetLikedUsersSuccessState({required this.likedUsers});
}