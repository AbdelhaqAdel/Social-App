import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';

abstract class PostDataRmoteDataSourse{
  Future <void>fetchPostData();
}
class PostDataRemoteDatasourceImpl extends PostDataRmoteDataSourse{
  PostModel? postData;
  List<String>postLikes=[];
  List<int>postLikeNum=[];
  List<int>postCommrntsNum=[];
  @override
  Future<void> fetchPostData()async {
  FirebaseFirestore.instance.collection('posts').orderBy('postDate').snapshots()
  .listen((event) {
      for (var element in event.docs) {
      getUsersLikes(element);
      getLikesNumber(element);
      getCommentsNumber(element);
      }
  });
}

 void getUsersLikes(element){
  postLikes=[];
    postLikes.add(element.id);
  }
  
 void getLikesNumber(element){
  postLikeNum=[];
      element.reference.collection('likes')
        .snapshots().listen((value) {
        postLikeNum.add(value.docs.length); 
        });
  }

void getCommentsNumber(element){
  postCommrntsNum=[];
      element.reference.collection('likes')
        .snapshots().listen((value) {
        postCommrntsNum.add(value.docs.length); 
        });
  }
  
}

  