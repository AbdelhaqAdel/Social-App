import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/stories/domain/repositories/status_repo.dart';

class AddUserStatusUseCase extends UseCase<void,String,Failure>{
  final StatusRepository repository;

  AddUserStatusUseCase(this.repository);

  @override
  Future<Either<Failure,void>> call([String?param]) {
    return repository.addUserStatus(statusText:param!);
  }
}
