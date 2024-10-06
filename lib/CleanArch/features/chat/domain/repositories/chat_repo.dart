import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>>addMessage(UserModel receiverModel, String message);

 Either<Failure,Stream<List<MessagesModel>>> getMessages( String userId);

  Future<Either<Failure,List<UserModel>>>getAllUsers();
}
