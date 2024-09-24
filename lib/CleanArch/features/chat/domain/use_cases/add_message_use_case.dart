import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/chat/domain/repositories/chat_repo.dart';

class AddMessageUseCase extends UseCase<void,String,Failure>{
  final ChatRepository repository;

  AddMessageUseCase(this.repository);
  
  @override
  Future<Either<Failure, void>> call([
     String? param,
     String? message,
  ]) {
    return repository.addMessage(param!,message!);
  }
}
