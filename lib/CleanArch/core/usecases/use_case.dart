import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Param,errorType> {
  Future<Either<errorType, Type>> call([Param param]);
}

class NoParam {}
