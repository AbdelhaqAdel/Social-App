import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/postss_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/post_comment_repo.dart';
import 'package:newapp/shared/Notification/notification_model.dart';
import 'package:newapp/shared/Notification/notification_services.dart';

class PostCommentRepository extends PostCommentRepo{
PostCommentRepository({required this.postsRepo});
  final PostRemoteDatasourceImpl postsRepo;
  @override
  Future<Either<Failure,void>>addComment(String postId,String newComment) async {
    try{
    var postDoc= FirebaseFirestore.instance.collection('posts').doc(postId);
         postDoc.get().then((value){
        String fcm=value['fcm'];
        int thisPostComments=value['comments'];
          postDoc.collection('comments').get().then((value) {
            addNewComment(postDoc,thisPostComments,newComment);
                sendNotification(fcmToken:fcm,
       notification:NotificationModel(title: 'New comment',
       body:'${userModel?.name} add $newComment comment on your post'),
       );
        });
        });
         return right(null); 
        }catch(e){
          if(e is FirebaseAuthException){return left(FirebaseError.firebaseException(e));}
          else{return left(ServerFailure(e.toString()));}
        } 
  }
  void addNewComment(postDoc,thisPostComments,comment){
   postDoc.collection('comments').doc('$uid-$thisPostComments').set({'user':userModel?.name,'comment':comment});
   postDoc.update({'comments':thisPostComments+1});
  }

}