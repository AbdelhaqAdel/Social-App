import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/utils/notification_services/notification_services.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/add_post_repo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:newapp/CleanArch/features/notification/data/notification_model.dart';


class AddPostRepoImpl extends AddPostRepo{
  @override
  Future<Either<String, void>> addPost({required String postText})async{
   try{
    PostModel model=PostModel(
     name:      userModel!.name,
     uId:       userModel!.uId,
     image:     userModel!.image,
     postImage: postImage,
     postText:  postText,
     postDate:  DateTime.now().toString(),
     postLikes:0,
     isUserLike:false,
     postComments: 0, fcmToken: fcmToken,
    );
   await FirebaseFirestore.instance.collection('posts')
        .add(model.toMap());
        FirebaseMessaging.instance.unsubscribeFromTopic('all').then((val){
         log('unsubscribed');
         sendNotification(notification:NotificationModel(title: 'New Post from ${model.name}',
       body:'check it now',image:postImage ));
       });
    return right(null);
   }catch(e){
     return left(e.toString());

   }
  }

  String? pickedFile;
  @override
 Future<Either<String, XFile>> pickPostImage()async{
    try{
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      pickedFile=file.path;
    return right(file);
    }
    return left('image not picked');
    }catch (e){
      return left(e.toString());
    }
  }

String? postImage;

@override
Future<Either<String, String?>> uploadPostImage() async {
  try {
    final uploadTask = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(pickedFile!).pathSegments.last}')
        .putFile(File(pickedFile!));
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    postImage = downloadUrl;
   return right(postImage);
  } catch (e) {
    return left(e.toString());
  }
}}
