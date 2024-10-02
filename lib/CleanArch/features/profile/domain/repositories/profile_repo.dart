import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

abstract class IProfileRepo {
  Future<Either<Failure, UserModel>> getUserProfile({required String uid});
}