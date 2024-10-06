import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/chat/domain/repositories/chat_repo.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class AddMessageUseCase extends UseCase<void,UserModel,Failure>{
  final ChatRepository repository;

  AddMessageUseCase(this.repository);
  
  @override
  Future<Either<Failure, void>> call([
     UserModel? param,
     String? message,
  ]) {
    return repository.addMessage(param!,message!);
  }
}
