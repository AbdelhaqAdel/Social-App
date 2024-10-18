import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/core/utils/firebase_handle_error.dart';
import 'package:newapp/CleanArch/core/utils/notification_services/notification_services.dart';
import 'package:newapp/CleanArch/features/chat/data/data_sources/all_users_remote_data_source.dart';
import 'package:newapp/CleanArch/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/chat/domain/repositories/chat_repo.dart';
import 'package:newapp/CleanArch/features/notification/data/notification_model.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  ChatRepositoryImpl({required this.remoteDataSource,required this.userRemoteDataSource});  

  @override
  Future<Either<Failure, void>> addMessage(UserModel receiverModel, String message) async {
    try {
      await remoteDataSource.addMessage(receiverModel, message);
      print('----------------------${receiverModel.fcmToken}');
      sendNotification(fcmToken: receiverModel.fcmToken,
       notification:NotificationModel(title: 'New Message from ${receiverModel.name}',
       body:message),);
      
      return const Right(null); 
    } catch (e) {
       if(e is FirebaseAuthException){return left(FirebaseError.firebaseException(e));}
      else{return left(ServerFailure(e.toString()));}
    }
  }

  @override
   Either<Failure,Stream<List<MessagesModel>>> getMessages(String userId) {
    try {
      final response= remoteDataSource.getMessages(userId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async{
     try {
      final response= await userRemoteDataSource.getAllUsers();
      return Right(response);
          } catch (e) {
      if(e is FirebaseAuthException){return left(FirebaseError.firebaseException(e));}
      else{return left(ServerFailure(e.toString()));}
   }
  }


}
