import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';

abstract class IAuthRepo {
  Future<Either<Failure,String>>signIn({
    required String email,
    required String password,
  });
  
  Future<Either<Failure, String>> signUp({
   required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname
  });

  Future<Either<Failure, RegisterModel>> getUserProfile();
}