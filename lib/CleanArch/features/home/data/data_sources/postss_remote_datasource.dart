import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';


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
 
    
    //  }
  //  }}
  //  else if(postsList.length<list.length){
  //     int newPostsNum=list.length-postsList.length;
  //      for (var element in list[newPostsNum]) {
  //        if(postsList.length<)
  //      postsList.add(PostModel.fromJson(element.data()));
  //     for(int i=0;i<newPostsNum;i++){
  //       postsList.add(PostModel.fromJson())
  //     }
  //   }
 
 
//  if(postsList.length < list.length){
//  for (int i = postsList.length; i < list.length; i++) {
//     postsList.add(PostModel.fromJson(list[i].data()));
//  }  
//    }
//  }

    // If the index exists in postsList, update the item
  //   if (i < postsList.length) {
  //     postsList[i] = postData;
  //   } else {
  //     // Otherwise, add the new item to the list
  //     postsList.add(postData);
  //   }
  // }
  // }


  
  // void GetAllPosts(){

  //   FirebaseFiarestore
  //       .instance.collection('posts').orderBy('postDate')
  //   //.orderBy('postDate',descending: true)
  //       .snapshots().listen((value) {//value is all collections in post  (all posts)
  //     posts=[];
  //     likesNum=[];
  //     likes=[];
  //     value.docs.forEach((element) {//element is map<String dynamic> contain all data in post model
  //       posts.add(PostModel.fromJson(element.data()));
  //       // changeLikeButtonColor(element.id);
  //       // print(isLiked);
  //     });
  //     // posts.forEach((element) {
  //     //   print('posts text ${element.postText}');
  //     // });
  //   });
  // }
}