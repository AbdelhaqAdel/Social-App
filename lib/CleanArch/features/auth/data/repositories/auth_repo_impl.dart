import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:newapp/CleanArch/features/auth/domain/repositories/auth_repo.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class AuthRepository implements IAuthRepo{

  final RemoteDataSource remoteDataSource;
  // final LocalDataSource localDataSource;
  
  AuthRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure,String>>signIn({
    required String email,
    required String password,
  })async{
    try{
    final response=await remoteDataSource.signIn(email: email, password: password);
      uid=response;
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
  void saveUserData(){
    //TODO save to cach helper
  }

  @override
  Future<Either<Failure, String>> signUp({
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
      final responce=await remoteDataSource.register(
        name: name, email: email, password: password, phone: phone,
         image: image, bio: bio, cover: cover, nickname: nickname);
         uid=responce;
         return right(responce);
    }catch(e){
       if(e is FirebaseAuthException){
       return left(FirebaseError.firebaseException(e));
     }else{
       return left(ServerFailure(e.toString()));
     }    
    }
  }

 @override
 Future<Either<String, UserModel>> getUserProfile() async {
    //TODO implement get user profile
        throw UnimplementedError();
  }




}