import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Param> {
  Future<Either<String, Type>> call([Param param]);
}

class NoParam {}
