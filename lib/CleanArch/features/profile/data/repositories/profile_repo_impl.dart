import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/features/profile/data/data_sources/profile_local_datasource.dart';
import 'package:newapp/CleanArch/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/features/profile/domain/repositories/profile_repo.dart';

class ProfileRepository implements IProfileRepo{

  final IProfileDataSource remoteDataSource;
  final IProfileLocalDataSource localDataSource;
  
  ProfileRepository({required this.remoteDataSource,required this.localDataSource});

 @override
 Future<Either<Failure, UserModel>> getUserProfile({required uid}) async {
  try{
    final response = await remoteDataSource.getUserData(uid: uid);
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