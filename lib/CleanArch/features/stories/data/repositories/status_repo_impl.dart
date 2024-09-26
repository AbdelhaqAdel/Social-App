import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/features/stories/data/data_sources/status_remote_data_source.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';
import 'package:newapp/CleanArch/features/stories/domain/repositories/status_repo.dart';

class StatusRepositoryImpl implements StatusRepository {
  final StatusRemoteDataSource remoteDataSource;
  StatusRepositoryImpl(this.remoteDataSource);

  @override
  Either<Failure,Stream<List<StatusModel>>> getAllStatus() {
    try{
    final response = remoteDataSource.getAllStatus();
    return right(response);
    }catch(e){
      if(e is FirebaseAuthException){return left(FirebaseError.firebaseException(e));}
      else{return left(ServerFailure(e.toString()));}
     }
  }
  
  @override
  Future<Either<Failure,void>> addUserStatus({required String statusText})async {
    try{
   final response=await remoteDataSource.addUserStatus(statusText: statusText);
   return right(response);
  }catch(e){
     if(e is FirebaseAuthException){return left(FirebaseError.firebaseException(e));}
      else{return left(ServerFailure(e.toString()));}
  }
  }
}