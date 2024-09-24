import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/chat/domain/repositories/chat_repo.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class GetAllUsersUseCase extends UseCase<List<UserModel>,NoParam,Failure>{
  final ChatRepository repo;

  GetAllUsersUseCase(this.repo);
  
  @override
   Future<Either<Failure, List<UserModel>>> call([NoParam? param]) async{
    return repo.getAllUsers();
  }
}
