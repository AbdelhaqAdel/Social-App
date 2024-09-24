import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/chat/domain/repositories/chat_repo.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);
  
   Either<Failure,Stream<List<MessagesModel>>> call({required String userId,}) {
    return repository.getMessages(userId);
  }
}


