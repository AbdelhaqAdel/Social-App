import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';


abstract class PostRmoteDataSourse{
  Future <List<PostModel>>fetchPosts();
}
class PostRemoteDatasourceImpl extends PostRmoteDataSourse{
  List<PostModel>postsList=[];

  @override
  Future<List<PostModel>> fetchPosts()async {
      FirebaseFirestore.instance.collection('posts').orderBy('postDate')
      .snapshots().listen((value) {
        fillPostsList(value.docs);
      });
    // HiveServices.saveDataToHive<PostModel>(HiveConstants.postBox,postsList, HiveConstants.postBox);
    GetPostsSuccessState.setAllPosts(postsList);
   return postsList;
}

 void fillPostsList(list) {
      postsList=[];
     for (var element in list){
          isCurrentUserLikeCurrentPost(element);
          postsList.add(PostModel.fromJson(element.data()));
       }
       print('----***************');
 }

 void isCurrentUserLikeCurrentPost(element){
    FirebaseFirestore.instance.collection('posts').doc(element.id)
          .collection('likes').get().then((value) {
            for (var e in value.docs) {
            if(uid==e.id) {
              FirebaseFirestore.instance.collection('posts').doc(element.id).update({'isUserLike':true});
              return;
            }
            }
           FirebaseFirestore.instance.collection('posts').doc(element.id).update({'isUserLike':false});
           return;
            });
 }
 
}