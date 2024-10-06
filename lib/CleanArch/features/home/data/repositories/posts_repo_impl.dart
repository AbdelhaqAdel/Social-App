import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/post_data_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/posts_local_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/postss_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/post.dart';


class PostRepository extends PostRepo{
  final PostRemoteDatasourceImpl postRemoteDataSource;
  final PostDataRemoteDatasourceImpl postData;
  final PostLocalDatasourceImpl postLocalDatasource;
  PostRepository({required this.postRemoteDataSource,required this.postLocalDatasource,required this.postData});
  List<String>postLikes=[];
  Map<String,int>postLikeNum={};
  List<int>postCommrntsNum=[];
  @override

  Future<Either<Failure, List<PostModel>>> getAllPosts()async {
    try{
      final List<PostModel>posts=await postRemoteDataSource.fetchPosts();
      postData.fetchPostData().then((value){
        postLikes=postData.postLikes;
        postLikeNum=postData.postLikeNum;
        postCommrntsNum=postData.postCommrntsNum;
      });
       FirebaseMessaging.instance.subscribeToTopic('all').then((val){
         log('subscribed');});
      return right(posts);
    }catch(e){
      if(e is FirebaseAuthException){return left(FirebaseError.firebaseException(e));}
      else{return left(ServerFailure(e.toString()));}
    }
  }

}