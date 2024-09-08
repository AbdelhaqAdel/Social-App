import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:newapp/CleanArch/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';
import 'package:newapp/CleanArch/features/auth/domain/repositories/auth_repo.dart';

class AuthRepository implements IAuthRepo{

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  
  AuthRepository({required this.remoteDataSource,required this.localDataSource});

  @override
  Future<Either<Failure,String>>signIn({
    required String email,
    required String password,
  })async{
    try{
    final response=await remoteDataSource.signIn(email: email, password: password);
      uid=response;
      print('uuuuuiiiiddddd$uid');
      return right(response);
    }catch(e){
      print('errrroooorrrrr');
      if(e is FirebaseAuthException){
       return left(FirebaseError.firebaseException(e));
     }else{
       return left(ServerFailure(e.toString()));
     }    
    }
  }
  
  @override
  Future<Either<Failure, RegisterModel>> signUp({
   required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname
  })
   async {
    try{
      final response=await remoteDataSource.register(
        name: name, email: email, password: password, phone: phone,
         image: image, bio: bio, cover: cover, nickname: nickname);
         userModel=response;
         return right(response);
    }catch(e){
       if(e is FirebaseAuthException){
       return left(FirebaseError.firebaseException(e));
     }else{
       return left(ServerFailure(e.toString()));
     }    
    }
  }

 @override
 Future<Either<Failure, RegisterModel>> getUserProfile({required uid}) async {
  try{
    final cachedData=await localDataSource.getUserData();
    print(cachedData.image);
    if(cachedData.image!=null){
      return right(cachedData);
    }
    final response = await remoteDataSource.getUserData(uid: uid);
    userModel=response;
    return right(response);
  }catch(e){
     if(e is FirebaseAuthException){
       return left(FirebaseError.firebaseException(e));
     }else{
       return left(ServerFailure(e.toString()));
     }   
  }
  }




}