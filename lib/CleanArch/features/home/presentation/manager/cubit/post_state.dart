part of 'post_cubit.dart';

sealed class PostState {}

final class PostInitial extends PostState {}

class GetPostsLoadingState extends PostState {}
class GetPostsSuccessState extends PostState {
  final List<PostModel>posts;
  final List<String>postLikes;
  final List<int>postLikeNum;
  final List<int>postCommrntsNum;

  GetPostsSuccessState({
    required this.posts,
  required this.postLikes,
  required this.postLikeNum,
  required this.postCommrntsNum});
  }
class GetPostsErrorState extends PostState {
  final String errMessage;
  GetPostsErrorState({required this.errMessage});
}
