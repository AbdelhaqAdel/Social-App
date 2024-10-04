import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/features/profile/domain/repositories/profile_repo.dart';

class ProfileRepository implements IProfileRepo{

  final IProfileDataSource remoteDataSource;
  // final IProfileLocalDataSource localDataSource;
  
  ProfileRepository({required this.remoteDataSource});

 @override
 Future<Either<Failure, UserModel>> getUserProfile({required uid}) async {
  try{
    final response = await remoteDataSource.getUserData(uid: uid);
    userData=response;
    return right(response);
  }catch(e){
     if(e is FirebaseAuthException){
       return left(FirebaseError.firebaseException(e));
     }else{
       return left(ServerFailure(e.toString()));
     }   
  }
  }

  // @override
  // Future<Either<String, void>> editProfile({required String postText})async{
  // //  try{
  // //   PostModel model=PostModel(
  // //    name:      userModel!.name,
  // //    uId:       userModel!.uId,
  // //    image:     userModel!.image,
  // //    postImage: postImage,
  // //    postText:  postText,
  // //    postDate:  DateTime.now().toString(),
  // //    postLikes:0,
  // //    isUserLike:false,
  // //    postComments: 0,
  // //   );
  // //  await FirebaseFirestore.instance.collection('posts')
  // //       .add(model.toMap());
  // //   return right(null);
  // //  }catch(e){
  // //    return left(e.toString());

  // //  }
  // }


String? postImage;
 @override
  Future<Either<String, void>> uploadProfileImage({required String pickedImage})async{

    try{
   await firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('posts/${Uri.file(pickedImage)
        .pathSegments.last}')
        .putFile(File(pickedImage)).then((value){
      value.ref.getDownloadURL().then((value) {
        postImage=value;
      });
  });
  return right(null);
    }catch(e){ 
      return left(e.toString());
}
  }}
