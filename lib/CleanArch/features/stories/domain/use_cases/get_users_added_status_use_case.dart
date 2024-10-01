import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/stories/domain/repositories/status_repo.dart';

class GetUserAddedStatusUseCase {
  final StatusRepository repository;

  GetUserAddedStatusUseCase(this.repository);

  Either<Failure,Stream<List<Map<String,dynamic>>>> call() {
    return repository.getAllUsersAddedStatus();
  }
}
