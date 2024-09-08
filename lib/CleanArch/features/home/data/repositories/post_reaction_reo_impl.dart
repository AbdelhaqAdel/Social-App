import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/postss_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/post_reaction_repo.dart';

class PostReactoinRepository extends PostReactoinRepo{
PostReactoinRepository({required this.postsRepo});
  final PostRemoteDatasourceImpl postsRepo;
  @override
  Future<void>addLike(String postId) async {
    print("'''''''''''''''''''''''''''''''''''''''''''");
    var postDoc= FirebaseFirestore.instance.collection('posts').doc(postId);
         postDoc.get().then((value){
        int thisPostLikes=value['likes'];
          postDoc.collection('likes').get().then((value) {
            for (var element in value.docs) {
              if(uid==element.id) {
              cancelLike(postDoc,thisPostLikes);
              return ;              
             }}
            addNewLike(postDoc,thisPostLikes);
            return ; 
        });
        }); 
  }
  void cancelLike(postDoc,thisPostLikes){
   postDoc.collection('likes').doc(uid).delete();
   postDoc.update({'likes':thisPostLikes-1});
   postDoc.update({'isUserLike':false});
  }
  void addNewLike(postDoc,thisPostLikes){
   postDoc.collection('likes').doc(uid).set({'user':userModel?.name});
   postDoc.update({'likes':thisPostLikes+1});
   postDoc.update({'isUserLike':true});
  }



}