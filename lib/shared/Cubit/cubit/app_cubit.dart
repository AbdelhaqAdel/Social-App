import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/shared/network/DioHelper.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
import '../../../models/NotificationModelAndAdabpter/NotificationHiveModel.dart';
import '../../../CleanArch/features/stories/data/models/status_model.dart';
import '../../../CleanArch/features/profile/data/models/user_model.dart';
import '../../../CleanArch/features/home/presentation/pages/add_post_screen.dart';
import '../../../CleanArch/features/home/presentation/pages/posts_screen.dart';
import '../../../CleanArch/features/stories/presentation/pages/status_screen.dart';
import '../../../CleanArch/features/profile/presentation/pages/user_profile.dart';
import '../../../CleanArch/features/chat/presentation/pages/all_chats_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../CleanArch/core/utils/hive_constant.dart';


part 'app_state.dart';




class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);

  //
  // TextEditingController nameController=TextEditingController();
  // TextEditingController bioController=TextEditingController();


  bool isLoginLoading=false;

  void LoginIsLoading(){
    isLoginLoading=!isLoginLoading;
    emit(LoginIsloadingStateState());
  }
  bool isPassword=true;
  void showPassword(){
    isPassword=!isPassword;
    emit(LoginPasswordState());
  }
 
 
  bool isBottomSheetShown=false;

  void changeBottomSheetState(isBottomSheetShown){
    isBottomSheetShown= !isBottomSheetShown;
    emit(changeBottoomSheetState());
  }

  String? remail;
  var pass;
  List<BottomNavigationBarItem>navBarItems=[
    BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(icon: Icon(Icons.message),
        label: 'Chats'
    ),
    BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),
        label: 'Post'
    ),
    BottomNavigationBarItem(icon: Icon(Icons.history),
        label: 'Status'
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person),
        label: 'Profile'
    )
  ];
  List<Widget>Screens=[
    PostsScreen(),
    MessagesScreen(),
    AddPostScreen(),
    StatusScreen(),
    USerProfile()
  ];
  int currentIndex=0;
  void ChangeCurrentIndex(int index){
    if(index==1){
      getAllUsers();
    }
    if(index==2){
      GetUserData();
      pickPostImage=null;
      emit(AddPostIndexState());
    }
    else if (index==4)
      {
        GetUserData();
        emit(shopGetUserSuccessState());
        currentIndex=index;
      }
    else{
   currentIndex=index;
   emit(ChangeCurrentIndexState());
  }
  }

  int colorIndex=0;
  List<Color>statusColor=[
    Colors.deepOrange,
    Colors.deepPurple,
   
    Colors.blue,
    Colors.redAccent,
  ];

  void changeCurrentStatusColorIndex(){
    if(colorIndex< statusColor.length-1) {
      colorIndex = colorIndex + 1;
    }
    else
      colorIndex=0;
    emit(ChangeStatusColorIndex());
  }


  bool isRegisLoading=false;
  void RegisterIsLoading(){
    isRegisLoading=!isRegisLoading;
    emit(RegisterIsloadingStateState());
  }
  /*---------------login-------------------*/
  Future<void> LoginMethod({
    required String email,
    required String password
}) async{
    final user = FirebaseAuth.instance;
    await user.signInWithEmailAndPassword(email: email, password: password).then((value) {
     emit(shopLoginSuccessState(value.user!.uid));
     print("user id : ${value.user!.uid}");
      //print(value.user!.uid.runtimeType);
    });
    print("login success.......");
  }
/*---------------------register-------------*/

  void Create_user({
    required String name,
    required String email,
    required String uId,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname,

  }){
    UserModel ?registerModel=UserModel(
      name:name,email: email,uId:uid!,phone: phone,image: image,bio: bio,cover :cover,nickname: nickname);
    FirebaseFirestore.instance.collection(Kusers).doc(uId).set(registerModel.toMap()).then((value) {
      emit(shopAddUserSuccessState(uId));
    }).catchError((onError){
      print(onError);
      emit(shopAddUserErrorState());

    });
  }



  Future<void> RegisterMethod({
    required String name,
    required String email,

    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname

  }) async{
    final user = FirebaseAuth.instance;
    await user.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      print("User Created");
      remail=email;
      pass=password;
      emit(shopRegisterSuccessState(value.user!.uid));
      CacheHelper.saveData(key: 'uid', value: value.user!.uid).then((value){
       print("uid from register : ${CacheHelper.getData('uid')}");
      });
      Create_user(name: name, email: email, uId: value.user!.uid, phone:phone,image:image,bio:bio,cover: cover,nickname: nickname);
      // print('user id : ${registerModel?.uid}');
      // users.add({
      //   'name':name,
      //   'email':email,
      //   'password':password,
      //   'phone':phone
      // }).then((value) {
      //   emit(shopAddUserSuccessState());
      // }).catchError((error){
      //   print("error add");
      //   emit(shopAddUserErrorState());
      //   print('add user error ${error}');
      // });
      print('user id : ${value.user!.uid}');
      //CacheHelper.savaData(key: 'uid', value: value.user!.uid);
    }).catchError((onError){
      print(onError);
      print("ERrrooooorrrr");
      emit(shopRegisterErrorState());
    });
  }

  /*-----------Get User Data------------*/


  UserModel? userModel;
  void GetUserData()async
  {
    emit(shopGetUserLoadingState());
  await  FirebaseFirestore.instance.collection(Kusers).doc(CacheHelper.getData('UID')).get()
        .then((value) {
         // print(CacheHelper.getData('uid'));
        //  print('token ${uid}');
          print('all user data ${value.data()}');
          userModel=UserModel.fromJson(json:value.data());
         // print('user image: ${userModel?.image}');
          emit(shopGetUserSuccessState());
    }).catchError((onError){
      print('getting user data error : ${onError.toString()}');
      emit(shopGetUserErrorState());
    });
  }





  // Uint8List? Image;
  // String? profileImage;
  // //var profileImage;
  // PickImage()async{
  //   final ImagePicker imagePicker =ImagePicker();
  //   XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
  //   if(file!=null){
  //     profileImage=file.path;
  //     Image=await file.readAsBytes();
  //     emit(ImageProfilePickedSuccessState());
  //   }
  //   else{
  //     print('no image selected');
  //     emit(ImageProfilePickedErrorState());
  //
  //   }
  // }

  // void updateUser({
  //   required String name,
  //   required String phone,
  //   required String bio
  // }){
  //   uploadProfileImage();
  //   emit(UserUpdateLoagingState());
  //   print('url image after kkkkkkkkkkk${profileImageUrl}');
  //   if(profileImageUrl!=null){
  //     UserRegisterModel model=UserRegisterModel(
  //       name,
  //       userModel!.email,
  //       userModel!.uId,
  //       phone,
  //       profileImageUrl,
  //       bio,
  //       userModel!.cover,
  //     );
  //     FirebaseFirestore.instance.collection(Kusers).doc(model.uId).update(model.toMap())
  //         .then((value) {
  //       GetUserData();
  //     }).catchError((error){
  //       print(error);
  //       emit(UserUpdateErrorState());
  //     });
  //   }else{
  //     UserRegisterModel model=UserRegisterModel(
  //         name,
  //         userModel!.email,
  //         userModel!.uId,
  //         phone,
  //         userModel!.image,
  //         bio,
  //         userModel!.cover
  //
  //     );
  //     FirebaseFirestore.instance.collection(Kusers).doc(model.uId).update(model.toMap())
  //         .then((value) {
  //       GetUserData();
  //     }).catchError((error){
  //       print(error);
  //       emit(UserUpdateErrorState());
  //     });
  //   }
  //
  // }
  //
  // String ?profileImageUrl;
  // void uploadProfileImage(){
  //   print('profile imageeeee: ${profileImage}');
  //   firebase_storage.FirebaseStorage
  //       .instance
  //       .ref()
  //       .child('users/${Uri.file(profileImage!)
  //       .pathSegments.last}')
  //       .putFile(File(profileImage!)).then((value){
  //         value.ref.getDownloadURL().then((value) {
  //           profileImageUrl=value;
  //           emit(ImageUploadSuccessState());
  //          // print('the picked image : ${value}');
  //         }).catchError((error){
  //           print('Errorrr ${Error}');
  //           emit(ImageUploadErrorState());
  //         });
  //   }).catchError((error){
  //     emit(ImageUploadErrorState());
  //     print('Puting file Error ${error}');
  //   });
  // }
  //
  //

  Uint8List? Image;
  String? profileImage;
  //var profileImage;
  PickProfileImage()async{
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      profileImage=file.path;
      Image=await file.readAsBytes();
      emit(ImageProfilePickedSuccessState());
    }
    else{
      print('no image selected');
      emit(ImageProfilePickedErrorState());

    }
  }

  void uploadProfileImage(
      {
        required String name,
        required String phone,
        required String bio,
        required String nickname,
      }
      ){
    emit(UserUpdateLoagingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(profileImage!)
        .pathSegments.last}')
        .putFile(File(profileImage!)).then((value){
      value.ref.getDownloadURL().then((value) {
        updateUserInfo(
          name: name,
          phone: phone,
          bio: bio,
          profileImage: value,
          nickname: nickname,
        );
        emit(ImageUploadSuccessState());
        // print('the picked image : ${value}');
      }).catchError((error){
        print('Errorrr ${Error}');
        emit(ImageUploadErrorState());
      });
    }).catchError((error){
      emit(UserUpdateErrorState());
      print('Puting file Error ${error}');
    });
  }

  Uint8List? coverImage;
  String? otherCoverImage;
  //var profileImage;
  PickCoverImage()async{
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      otherCoverImage=file.path;
      coverImage=await file.readAsBytes();
      emit(ImageCoverPickedSuccessState());
    }
    else{
      print('no image selected');
      emit(ImageCoverPickedErrorState());

    }
  }

  void updateUserInfo({
  required String name,
  required String phone,
  required String bio,
  String? coverImage,
  String? profileImage,
  String?nickname,
}){
UserModel model=UserModel(
  name:name,
  email:userModel!.email,
   uId: userModel!.uId,
 phone: phone,
  image:profileImage??userModel!.image,
  bio: bio,
  cover: coverImage?? userModel!.cover,
 nickname:nickname??userModel!.nickname,
);
FirebaseFirestore.instance.collection(Kusers).doc(model.uId).update(model.toMap())
    .then((value) {
GetUserData();
}).catchError((error){
print(error);
emit(UserCoverUpdateErrorState());
});
}

  void uploadCoverImage(
      {
        required String name,
        required String phone,
        required String bio,
        required String nickname,
      }
 ){
    emit(UserCoverUpdateLoagingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(otherCoverImage!)
        .pathSegments.last}')
        .putFile(File(otherCoverImage!)).then((value){
      value.ref.getDownloadURL().then((value) {
        updateUserInfo(
          name: name,
          phone: phone,
          bio: bio,
          coverImage: value,
          nickname: nickname
        );
        emit(ImageCoverUploadSuccessState());
        // print('the picked image : ${value}');
      }).catchError((error){
        print('Errorrr ${Error}');
        emit(ImageCoverUploadErrorState());
      });
    }).catchError((error){
      emit(ImageCoverUploadErrorState());
      print('Puting file Error ${error}');
    });
  }

  void AddPost({
    String? postText,
  }){
    emit(ImagePostUploadLoadingState());
    PostModel model=PostModel(
     name:      userModel!.name,
     uId:       userModel!.uId,
     image:     userModel!.image,
     postImage: postImage,
     postText:  postText,
     postDate:  DateTime.now().toString(),
     postLikes:0,
     isUserLike:false,
     postComments: 0,
    );
    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value){
          emit(ImagePostUploadSuccessState());
    })
        .catchError((error){
         emit(ImagePostUploadErrorState());
    });
  }

  Uint8List? pickPostImage;
  String? stringPostImage;
  PickPostImage()async{
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      stringPostImage=file.path;
      pickPostImage=await file.readAsBytes();
      print('image  :: ${pickPostImage}');
      emit(ImagePostPickedSuccessState());
    }
    else{
      emit(ImagePostPickedErrorState());
    }
  }

  String? postImage;
  void uploadPostImage(){
        emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('posts/${Uri.file(stringPostImage!)
        .pathSegments.last}')
        .putFile(File(stringPostImage!)).then((value){
      value.ref.getDownloadURL().then((value) {
        postImage=value;
        emit(CreatePostSuccessState());
        // print('the picked image : ${value}');
      }).catchError((error){
        print('Errorrr ${Error}');
        emit(CreatePostErrorState());
      });
    }).catchError((error){
      emit(CreatePostErrorState());
      print('Puting file Error ${error}');
    });
  }

  List<PostModel>posts=[];
  List<String>likes=[];
  List<int> likesNum=[];
  List<int> commentNum=[];
 // int likeee=0;
 //  void GetPostsData(){
 //    emit(GetPostLoadingState());
 //
 //    FirebaseFirestore
 //        .instance.collection('posts')
 //        //.orderBy('postDate',descending: true)
 //        .get().then((value) {//value is all collections in post  (all posts)
 //      value.docs.forEach((element) {//element is map<String dynamic> contain all data in post model
 //
 //        element.reference.collection('likes')  //to go to likes collection from post
 //            .get().then((value) {
 //              //print(value.);
 //              likesNum.add(value.docs.length);    //add number of items in likes collection to likkesNum list
 //              likes.add(element.id);
 //              posts.add(PostModel.fromJson(element.data()));    //to add all data in element to posts list
 //            }).catchError((error){
 //
 //            });
 //        element.reference.collection('comments')  //to go to likes collection from post
 //            .get().then((value) {
 //          //print(value.);
 //          commentNum.add(value.docs.length);    //add number of items in likes collection to likkesNum list
 //        });
 //       // changeLikeButtonColor(element.id);
 //         // print(isLiked);
 //         });
 //          // posts.forEach((element) {
 //          //   print('posts text ${element.postText}');
 //          // });
 //          emit(GetPostSuccessState());
 //    }).catchError((error){
 //      print('error from getting posts ${error}');
 //          emit(GetPostErrorState());
 //    });
 //  }
  
  void GetAllPosts(){
    emit(GetPostLoadingState());

    FirebaseFirestore
        .instance.collection('posts').orderBy('postDate')
        .snapshots().listen((value) {//value is all collections in post  (all posts)
      posts=[];
      likesNum=[];
      likes=[];
      value.docs.forEach((element) {//element is map<String dynamic> contain all data in post model
        posts.add(PostModel.fromJson(element.data()));
        GetPostsData();
        // changeLikeButtonColor(element.id);
        // print(isLiked);
      });
      // posts.forEach((element) {
      //   print('posts text ${element.postText}');
      // });
      emit(GetPostSuccessState());
    });
  }
 
  void GetPostsData(){
    emit(GetPostDataLoadingState());

    FirebaseFirestore
        .instance.collection('posts').orderBy('postDate')
        .snapshots().listen((value) {//value is all collections in post  (all posts)
      value.docs.forEach((element) {//element is map<String dynamic> contain all data in post model
        likes.add(element.id);
        element.reference.collection('likes')  //to go to likes collection from post
            .snapshots().listen((value) {

          likesNum?.add(value.docs.length);    //add number of items in likes collection to likkesNum list
          //to add all data in element to posts list
        });
        element.reference.collection('comments')  //to go to likes collection from post
            .snapshots().listen((value) {
          //print(value.);
          commentNum?.add(value.docs.length);    //add number of items in likes collection to likkesNum list
        });
        // changeLikeButtonColor(element.id);
        // print(isLiked);
      });
      // posts.forEach((element) {
      //   print('posts text ${element.postText}');
      // });
      emit(GetPostDataSuccessState());
    });
  }

  List likedName=[];
  void getLikedUsers(String postId){
    emit(GetPostsLikesLoadingState());
    likedName = [];
    FirebaseFirestore.instance.collection('posts')
        .doc(postId).collection('likes')
        .get().then((value) {
      value.docs.forEach((element) {
        likedName.add(element.get('user'));
        print(' users liked ${element.get('user')}');
        emit(GetPostsLikesSuccessState());
      });
    }).catchError((error){
      print('get likes users error${error}');
      emit(GetPostsLikesErrorState());

    });
    //     .get().then((value) {
    //   print(value.get(''));
    // });
    //}');
  }

  //List<bool> isLiked=[];
  bool isLiked=false;
  Map<String,bool>?userLiked;

  void changeLikeButtonColor(String postId){
    FirebaseFirestore.instance.collection('posts')
      .doc(postId).collection('likes')
      .get().then((value) {
      //  print('ddd');
       // value.docs.forEach((element)
       for(var n in value.docs){

          if (userModel?.uId == n.reference.id) {
            userLiked?.addAll({
              postId:true
            });
            isLiked = true;
          }
     
        }

    emit(GetIsLikedSuccessState());

    }).catchError((error){
    print('get likes users error${error}');
    emit(GetIsLikedErrorState());

  });}


//  Future<bool>isUserLike(postDoc){
//          postDoc.collection('likes').get().then((value) {
//             value.docs.forEach((element) {
//               if(uid==element.id) {
//                 print('userrrrrr$uid------------${element.id}');
//               }
//             });
//           });
//  }
   
  
  // bool isUserTap=false;
  // void changeLikeButton(){
  //  isUserTap = !isUserTap;
  //  emit()
  // }


  void addLike(String postId){
    var postDoc= FirebaseFirestore.instance.collection('posts').doc(postId);
         postDoc.get().then((value){
        int thisPostLikes=value['likes'];
          postDoc.collection('likes').get().then((value) {
            for (var element in value.docs) {
              if(uid==element.id) {
             postDoc.collection('likes').doc(uid).delete();
             postDoc.update({'likes':thisPostLikes-1});
             postDoc.update({'isUserLike':false});
             return;              
             }}
            postDoc.collection('likes').doc(uid).set({'user':userModel?.name});
             postDoc.update({'likes':thisPostLikes+1});
             postDoc.update({'isUserLike':true});
            return; 
        });
        }); 
  }

  void addComment(String postId,String comment){
    FirebaseFirestore.instance.collection('posts')
        .doc(postId).collection('comments')
        .doc(userModel?.uId).set({
      'comment':comment,
      'user':userModel?.name
    })
        .then((value) {
      print('add comment');
      emit(UserAddPostLikeSuccessState());
    }).catchError((error){
      print('add like error ${error}');
      emit(UserAddPostLikeErrorState());
    });
  }






  Uint8List? pickStatusImage;
  String? stringStatusImage;
  PickStatusImage()async{
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      stringStatusImage=file.path;
      pickStatusImage=await file.readAsBytes();
      emit(ImageStatusPickedSuccessState());
    }
    else{
      print('no image selected');
      emit(ImageStatusPickedErrorState());

    }
  }

  String? statusImage;
  void uploadStatusImage(){
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('status/${Uri.file(stringStatusImage!)
        .pathSegments.last}')
        .putFile(File(stringStatusImage!)).then((value){
      value.ref.getDownloadURL().then((value) {
        statusImage=value;
        emit(CreateStatusSuccessState());
        // print('the picked image : ${value}');
      }).catchError((error){
        print('Errorrr ${Error}');
        emit(CreateStatusErrorState());
      });
    }).catchError((error){
      emit(CreateStatusErrorState());
      print('Puting file Error ${error}');
    });
  }



  void AddUsersStatus({
    String? statusText,
    //Color? color,
  }){
    emit(ImageStatusUploadLoadingState());
    StatusModel model=StatusModel(
      userModel!.name,
      userModel!.uId,
      userModel!.image,
      statusImage,
      statusText,
      DateTime.now().toString(),
      //color??Colors.white,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(userModel?.uId).collection('status')
        .add(model.toMap())
        .then((value){

      print('status created true');
      emit(ImageStatusUploadSuccessState());
     // id=id+1;
    })
        .catchError((error){
      print('wwwwwErroorrrr ${error}');
      emit(ImageStatusUploadErrorState());
    });
  }

  Stream<QuerySnapshot> getStatusUpdates() {
    return FirebaseFirestore.instance
        .collection(Kusers)
        .doc(userModel?.uId)
        .collection('status')
        .orderBy('postDate', descending: true)
        .snapshots();
  }


  List<StatusModel>allUserAddStatus=[];
  void whoUserAddStory()async {
    emit(GetUserAddStatusLoadingState());

    await FirebaseFirestore.instance.collection(Kusers).get().then((value){
      value.docs.forEach((element) {
        // print(element.id);
        element.reference.collection('status').get().then((value) {
          value.docs.forEach((element) {
            if(DateTime.parse(element.get('postDate')).hour<=DateTime.now().hour
                &&DateTime.parse(element.get('postDate')).day!=DateTime.now().day
            ){
              element.reference.delete();
              print('cleared::${DateTime.now().hour+1}');
              print(DateTime.parse(element.get('postDate')).hour);
            }
            else{
              print('sss');
            }
          });
          //  print(value.docs.isEmpty);
          if(value.docs.isNotEmpty){
            allUserAddStatus.add(StatusModel.fromJson(element.data()));
          }
          emit(GetUserAddStatusSuccessState(status: allUserAddStatus));
        });
      });
      // print('lllll${allUserAddStatus.length}');
    }).catchError((error){
      print('getting all ststus user error ${error}');
      emit(GetUserAddStatusErrorState());

    });

  }




  // List<PostModel> convertQuerySnapshotToList(QuerySnapshot querySnapshot) {
  //   List<PostModel> postList = [];

  //   querySnapshot.docs.forEach((doc) {
  //     var data = doc.data() as Map<String, dynamic>;

  //     var post = PostModel(
  //       // Replace these with the actual fields in your PostModel
  //       data['name'],
  //       data['uId'],
  //       data['image'],
  //       data['postImage'],
  //       data['postText'],
  //       data['postDate'],
  //     );

  //     postList.add(post);
  //   });

  //   return postList;
  // }



 List <StatusModel> convertListQuerySnapshotToList(QuerySnapshot querySnapshot) {
   List <StatusModel> statusList=[] ;
    querySnapshot.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>;

      var status = StatusModel(
        // Replace these with the actual fields in your PostModel
        data['name'],
        data['uId'],
        data['image'],
        data['postImage'],
        data['postText'],
        data['postDate'],
      );

      statusList.add(status);
    });

    return statusList;
  }

  List<StatusModel> allStatus=[];
  void anotherGetStatus(String? userId)async
  {
    emit(GetStatusLoadingState());

    await  FirebaseFirestore.instance.collection(Kusers).doc(userId).collection('status')
        .get().then((value) {

      value.docs.forEach((element) {

       allStatus.add(StatusModel.fromJson(element.data()));
       print('${DateTime.now().hour}');

        // print('not cleared ${DateTime.now().minute}');
       // print(DateTime.parse(element.get('postDate')).minute);

      //  print('${DateTime.parse(element.get('postDate')).hour.toInt()}  ss'
      //      ' ${DateTime.parse(DateTime.now().hour.toString())}');
      });
      emit(GetStatusSuccessState());

    }).catchError((error){
      print('error from get status : ${error}');
      emit(GetStatusErrorState());

    });
    // doc('RtFLE0gwZkqupKZB9pff')
    //     .get().then((value) {
    //       allStatus=statusModel.fromJson(value.data()!);
    // }).catchError((error){
    //   print('errorrr: ${error}');
    // });
    //print('dddddd : ${allStatus![2].postText}');

  }


  List<UserModel>allUsers=[];

  void getAllUsers(){
    emit(GetUserLoadingState());
    if(allUsers.length==0) {
      FirebaseFirestore.instance.collection('${Kusers}').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel?.uId) {
            allUsers.add(UserModel.fromJson(json:element.data()));
          }
        });
        emit(GetUserSuccessState());
      }).catchError((error) {
        print('getting all users error ${error}');
        emit(GetUserErrorState());
      });
    }
  }

  void addToUserChat({
    required String userId,
    required String message
  }
      ){
    emit(AddChatLoadingState());
    MessagesModel model =MessagesModel(
      message,
      userModel!.uId,
    //    DateFormat.jm().format(DateTime.now())
    DateTime.now().toString(),
    );
    FirebaseFirestore.instance.collection('${Kusers}')
        .doc(userModel!.uId).collection('allChats')
        .doc(userId).collection('chatwith').add(
      model.toMap()
    ).then((value) {
     emit(AddChatSuccessState());
    }).catchError((error){
      emit(AddChatErrorState());
    });


    FirebaseFirestore.instance.collection('${Kusers}')
        .doc(userId).collection('allChats')
        .doc(userModel!.uId).collection('chatwith').add(
        model.toMap()
    ).then((value) {
      emit(AddChatSuccessState());
    }).catchError((error){
      emit(AddChatErrorState());
    });
  }


  // String usetId='';
  // void ChangeChatIndex (String userId){
  //   usetId=userId;
  //   emit(ChangeChatIndexState());
  // }

 // CollectionReference ?messages;
  List<MessagesModel>message=[];
  void getMessages(String userId){
    message=[];
    emit(GetAllMessagesLoadingState());
    try{
    FirebaseFirestore.instance.collection(Kusers)
        .doc(userModel?.uId).collection('allChats')
        .doc(userId).collection('chatwith').orderBy('date').snapshots()
         .listen((event)  {
          //  message=[];
           for (var element in event.docs) {
            message.add(MessagesModel.fromJson(element.data()));
             print(element.data());
           }
    });
    emit(GetAllMessagesSuccessState());
    }catch(e){
          emit(GetAllMessagesErrorState());
    }
    // FirebaseFirestore.instance.collection('${Kusers}')
    //     .doc(userModel!.uId).collection('allChats')
    //     .doc(userId).collection('chatwith').get().then((value) {
    //       value.docs.forEach((element) {
    //         print(element.data());
    //          message.add(MessagesModel.fromJson(element.data()));
    //       });
    //       message.forEach((element) {
    //         print(element.message);
    //       });

   
  }

  // Stream<QuerySnapshot> getMessagesUpdates(String userId) {
  //   return  FirebaseFirestore.instance.collection('${Kusers}')
  //       .doc(userModel!.uId).collection('allChats')
  //       .doc(userId).collection('chatwith')
  //       .orderBy('date', descending: true)
  //       .snapshots();
  // }

// List<statusModel>status=[];
// List<String>statusId=[];
// List<int> statulikesNum=[];
// void GetStatus(){
//   emit(GetStatusLoadingState());
//
//   FirebaseFirestore
//       .instance.collection('status')
//       .get().then((value) {//value is all collections in post  (all posts)
//     value.docs.forEach((element) {//element is map<String dynamic> contain all data in post model
//       statusId.add(element.id);
//       status.add(statusModel.fromJson(element.data()));    //to add all data in element to posts list
//       // element.reference.collection('likes')  //to go to likes collection from post
//       //     .get().then((value) {
//       //   likesNum.add(value.docs.length);    //add number of items in likes collection to likkesNum list
//       //
//       // }).catchError((error){
//       //
//       // });
//     //  changeLikeButtonColor(element.id);
//
//     });
//     status.forEach((element) {
//       print('status text ${element.postText}');
//     });
//     emit(GetStatusSuccessState());
//   }).catchError((error){
//     print('error from getting posts ${error}');
//     emit(GetStatusErrorState());
//   });
// }

//
// void AddStatus({
//   String? postText,
// }){
//   emit(ImageStatusUploadLoadingState());
//   statusModel model=statusModel(
//     userModel!.name,
//     userModel!.uId,
//     userModel!.image,
//     statusImage,
//     postText,
//     DateTime.now().toString(),
//   );
//   FirebaseFirestore.instance.collection('status')
//       .add(model.toMap())
//       .then((value){
//     print('status created true');
//     emit(ImageStatusUploadSuccessState());
//   })
//       .catchError((error){
//     print('wwwwwErroorrrr ${error}');
//     emit(ImageStatusUploadErrorState());
//   });
// }

// void updateUserInfo({
//   required String name,
//   required String phone,
//   required String bio,
//   String? coverImage,
//   String? profileImage,
// }){
//   UserRegisterModel model=UserRegisterModel(
//     name,
//     userModel!.email,
//     userModel!.uId,
//     phone,
//     userModel!.image,
//     bio,
//     coverImage?? userModel!.cover,
//   );
//   FirebaseFirestore.instance.collection(Kusers).doc(model.uId).update(model.toMap())
//       .then((value) {
//     GetUserData();
//   }).catchError((error){
//     print(error);
//     emit(UserCoverUpdateErrorState());
//   });
// }

// List<String>allUsersStatus=[];
  // void getAllStatus(){
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .get().then((value) {
  //         value.docs.forEach((element) {
  //          if(! element.get('status').isNull){
  //            // element.data().forEach((key, value){
  //            //
  //            // })
  //            allUsersStatus.add(element.get('name'));
  //            //allUsersStatus.add(statusModel.fromJson(value.))
  //            print('status is not null');
  //          }
  //          allUsersStatus.forEach((element) {
  //            print(element.length);
  //          });
  //         });
  //   }).catchError((error){
  //
  //   });
  // }

  // List <statusModel>userStatus=[];
  // Map<String,dynamic>?allStatusAsMap;
  //  void getUSerStatus(String userId){
  //    FirebaseFirestore.instance
  //        .collection('users')
  //        .doc(userId).collection('status').get().then((value) {
  //        value.docs.forEach((element) {
  //          userStatus.add(statusModel.fromJson(element.data()));
  //        });
  //        userStatus.forEach((element) {
  //          print(element.postText);
  //        });
  //        //elementAt().get('postText');
  //          //     .forEach((element) {
  //          //   print(element.get('postText'));
  //          // });
  //    }).catchError((error){});
  //  }

//
    // void getLikesByName(String postId){
    //   FirebaseFirestore.instance.collection('posts')
    //       .doc(postId).collection('likes').doc('abdelhaq').get().then((value) {
    //         print(value.data().);
    //   }).catchError((error){
    //
    //   });
    // }

  // FirebaseFirestore
  //     .instance.collection('posts')
  //     .get().then((value) {             //value is all collections in post  (all posts)
  // value.docs.forEach((element) {    //element is map<String dynamic> contain all data in post model
  // element.reference.collection('likes')   //to go to likes collection from post
  //     .get().then((value) {
  // likesNum.add(value.docs.length);    //add number of items in likes collection to likkesNum list
  // likes.add(element.id);
  // posts.add(PostModel.fromJson(element.data()));    //to add all data in element to posts list
  // }).catchError((error){
  //
  // });

// String? firstprofileImage;
//   XFile? profileImage;
//   var picker=ImagePicker();
//   Future<void> getProfileImage()async
//   {
//     final pickedFile=await picker.pickImage(source: ImageSource.gallery).then((value){
//       if(value != null){
//         profileImage=XFile(value.path).readAsBytes() as XFile?;
//         emit(ImageProfilePickedSuccessState());
//       }
//     });
//     if(pickedFile !=null){
//
//     }
//     else{
//       firstprofileImage='https://th.bing.com/th/id/R.581eb679a50357ed30ad0d7544081ec6?rik=54dcWNzgeTMHEg&pid=ImgRaw&r=0';
//       emit(ImageProfilePickedErrorState());
//     }
//   }



  // String ?profileImage;
  // final ImagePicker picker = ImagePicker();
  // XFile? pickedFile;
  //
  // Future<void> getLostData() async {
  //   final LostDataResponse response = await picker.retrieveLostData();
  //   pickedFile= await picker.pickImage(source:ImageSource.gallery);
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   final XFile? files = response.file;
  //   if (pickedFile != null) {
  //     pickedFile=XFile(pickedFile!.path);
  //     emit(ImageProfilePickedSuccessState());
  //   } else {
  //     profileImage='https://th.bing.com/th/id/R.581eb679a50357ed30ad0d7544081ec6?rik=54dcWNzgeTMHEg&pid=ImgRaw&r=0';
  //     emit(ImageProfilePickedErrorState());
  //   }
  // }

  // bool isPassword=true;
  // void showPassword(){
  //   isPassword=!isPassword;
  //   emit(LoginPasswordState());
  // }



//------------------------Notification --------------------


  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print("Handling a background message: ${message.data.toString()}");
  }


  final _firebaseMessaging=FirebaseMessaging.instance;


  Future<void> initNotification()async{
    await _firebaseMessaging.getToken().then((value) {
      print('FBM TOKEN ---------------------- $value');

    }).catchError((onError){
      print('notification error $onError');
    });
  }

  // var MToken=await _firebaseMessaging.getToken().then((value) {
  // print('device token -------: $value');
  // });

  //when app is open

  // void onMessageSend(){
  //   emit(OnMessageSendLoadingState());
  //    FirebaseMessaging.onMessage.listen((event) {
  //     print('on message data :${event.data.toString()}');
  //     print('on message from :${event.from.toString()}');
  //     //print(event.notification)
  //   });
  //
  //    FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //      print('on meaasage opened app data :${event.data.toString()}');
  //      //print(event.notification)
  //    });
  //
  //    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // }







  void sendNewNotification(){
    emit(SendNotifyLoadingState());
    Dio_Helper.PostData(url:'send',
      data: {
        "to":"/topics/all",
        "notificaion":{
          "title":"you have new post from ${userModel?.name}",
          "body":"testing body",
          "sound":"default"
        },
        "android":{
          "priority":"HIGH",
          "notification":{
            "notificaion_priority":"PRIORITY_MAX",
            "sound":"default",
            "default_sound":"true"
          }
        },
        "data":{
          "type":"new post from ${userModel?.name}",
          "id":"87",
          "click_action":"FLUTTER_NOTIFICATION_CLICK"
        }
      }
    ).then((value) {
    // if(value.statusCode==200){

      print('sent successful');

      emit(SendNotifySuccessState());
    // }
    }).catchError((onError){
      print('error to send notify $onError');
      storeNotificationToHive();
      emit(SendNotifyErrorState());
    });
  }

  //when click on notification to open app


  //background FCM


  final Box notifyBox=Hive.box(HiveConstants.notifyBox);
  void storeNotificationToHive (){
    print('Adding to notification ------//////');

    emit(AddnewnotifyToHiveLoadingState());
    List<NotificationModel> notifyList =
     notifyBox.get(HiveConstants.notifyBox,defaultValue: []).
    cast<NotificationModel>();

    notifyList.add(
     NotificationModel(
          hiveIndex:notifyBox.length,
          notifyMessage:'${userModel?.name} added new post',
          notifyTime: DateFormat("${DateTime.now().day} / ${DateTime.now().month}\n${DateTime.now().hour} "
              ": ${DateTime.now().minute}am ").format(DateTime.now()),
        ));
    notifyBox.put(HiveConstants.notifyBox, notifyList).then((value) {
      emit(AddnewNotifyToHiveSuccessState());
    }).catchError((error) {
      print('error to store to notify');
      print(error);
      emit(AddnewNotifyToHiveErrorState());
    });
  }



}