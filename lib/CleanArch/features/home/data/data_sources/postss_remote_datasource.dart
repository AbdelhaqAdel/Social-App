import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';

abstract class PostRemoteDataSource{
 Stream<List<PostModel>>fetchPosts();
}
class PostRemoteDataSourceImpl extends PostRemoteDataSource{
  List<PostModel>postsList=[];
@ override
Stream<List<PostModel>> fetchPosts() {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('postDate')
      .snapshots()
      .map((snapshot) {
        fillPostsList(snapshot.docs);
        // GetPostsSuccessState.setAllPosts(postsList);
        // HiveServices.saveDataToHive<PostModel>(HiveConstants.postBox, postsList, HiveConstants.postBox); // Uncomment if needed
        return postsList;
      });
}

 void fillPostsList(list) {
      postsList=[];
     for (var element in list){
          isCurrentUserLikeCurrentPost(element);
          postsList.add(PostModel.fromJson(element.data()));
       }
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