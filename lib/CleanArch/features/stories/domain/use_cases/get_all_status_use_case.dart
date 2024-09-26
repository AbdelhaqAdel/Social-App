import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';
import 'package:newapp/CleanArch/features/stories/domain/repositories/status_repo.dart';

class GetAllStatusUseCase {
  final StatusRepository repository;

  GetAllStatusUseCase(this.repository);

  Either<Failure,Stream<List<StatusModel>>> call() {
    return repository.getAllStatus();
  }
}
