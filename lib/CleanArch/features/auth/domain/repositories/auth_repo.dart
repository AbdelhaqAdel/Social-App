import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

abstract class IAuthRepo {
  Future<Either<Failure,String>>signIn({
    required String email,
    required String password,
  });
  
  Future<Either<String, SignUpModel>> signUp({
    required String email,
    required String password,
  });
    void saveUserData();

  Future<Either<String, UserModel>> getUserProfile();
}