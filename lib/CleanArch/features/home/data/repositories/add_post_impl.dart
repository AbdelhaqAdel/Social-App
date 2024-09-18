import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/add_post_repo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


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
     postComments: 0,
    );
   await FirebaseFirestore.instance.collection('posts')
        .add(model.toMap());
    return right(null);
   }catch(e){
     return left(e.toString());

   }
  }

  Uint8List? imageAsByte;
  String? pickedFile;
  @override
 Future<Either<String, XFile>> pickPostImage()async{
    try{
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      pickedFile=file.path;
      imageAsByte=await file.readAsBytes();
    return right(file);
    }
    return left('image not picked');
    }catch (e){
      return left(e.toString());
    }
  }

String? postImage;
 @override
  Future<Either<String, void>> uploadPostImage()async{
          print('picked Fileeeee $pickedFile');
    try{
   await firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('posts/${Uri.file(pickedFile!)
        .pathSegments.last}')
        .putFile(File(pickedFile!)).then((value){
      value.ref.getDownloadURL().then((value) {
        print('------------------$value');
        postImage=value;
      });
  });
  return right(null);
    }catch(e){ 
      return left(e.toString());
}
  }}