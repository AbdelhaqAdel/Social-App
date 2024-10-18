import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/posts_local_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/postss_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/post.dart';


class PostRepository extends PostRepo{
  final PostRemoteDataSourceImpl postRemoteDataSource;
  final PostLocalDataSourceImpl postLocalDatasource;
  PostRepository({required this.postRemoteDataSource,required this.postLocalDatasource});
  // List<String>postLikes=[];
  // Map<String,int>postLikeNum={};
  // List<int>postCommentsNum=[];

@override
Either<Failure, Stream<List<PostModel>>> getAllPosts() {
  try {
    final postsStream = postRemoteDataSource.fetchPosts();
    // postsStream.listen((posts) {
    //   print('posts ------------------: ${posts.length}');
    // });
    // postData.fetchPostData().then((value) {
    //   // postLikes = postData.postLikes;
    //   // postLikeNum = postData.postLikeNum;
    //   // postCommentsNum = postData.postCommentsNum;
    // });

    // FirebaseMessaging.instance.subscribeToTopic('all').then((val) {
    //   log('Subscribed to topic: all');
    // });

    return right(postsStream);
  } catch (e) {
    if (e is FirebaseAuthException) {
      return left(FirebaseError.firebaseException(e));
    } else {
      return left(ServerFailure(e.toString()));
    }
  }
}


  // @override
  // Either<Failure,Stream<List<PostModel>>> getAllPosts() {
  //   try{
  //     final List<PostModel>posts= postRemoteDataSource.fetchPosts();
  //     postData.fetchPostData().then((value){
  //       postLikes=postData.postLikes;
  //       postLikeNum=postData.postLikeNum;
  //       postCommrntsNum=postData.postCommrntsNum;
  //     });
  //      FirebaseMessaging.instance.subscribeToTopic('all').then((val){
  //        log('subscribed');});
  //     return right(posts);
  //   }catch(e){
  //     if(e is FirebaseAuthException){return left(FirebaseError.firebaseException(e));}
  //     else{return left(ServerFailure(e.toString()));}
  //   }
  // }

}