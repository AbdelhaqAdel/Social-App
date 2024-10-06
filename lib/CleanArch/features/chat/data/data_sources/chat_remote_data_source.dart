import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> addMessage(UserModel receiverModel, String message);
  Stream<List<MessagesModel>> getMessages(String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<void> addMessage(UserModel receiverModel, String message) async {
    var allUsers=FirebaseFirestore.instance.collection(kUsers);
    try {
     Future.wait([
      addUserModelToAllChats(receiverModel,allUsers),
      addMessageToChat(receiverModel,allUsers,message),  
     ]);
    } catch (e) {
      throw Exception('Error adding message: $e');
    }
  }
  
  Future<void> addUserModelToAllChats(UserModel receiverModel,allUsers) async{
        await allUsers
          .doc(uid)
          .collection(kAllChats)
          .doc(receiverModel.uId).set(receiverModel.toMap());

         await allUsers
          .doc(receiverModel.uId)
          .collection(kAllChats)
          .doc(uid).set(userData!.toMap());
  }
  
  Future<void> addMessageToChat(UserModel receiverModel,allUsers,String message) async{
        await allUsers
          .doc(uid)
          .collection(kAllChats)
          .doc(receiverModel.uId)
          .collection(kChatWith)
          .add(createMessage(message).toMap());
       await  allUsers
          .doc(receiverModel.uId)
          .collection(kAllChats)
          .doc(uid)
          .collection(kChatWith)
          .add(createMessage(message).toMap());
  }

  MessagesModel createMessage(String message) {
    return MessagesModel(
      message,
      uid,
      DateTime.now().toString(),
    );
  }

  @override
  Stream<List<MessagesModel>> getMessages(String userId) {
    try {
      return FirebaseFirestore.instance
          .collection(kUsers)
          .doc(uid)
          .collection(kAllChats)
          .doc(userId)
          .collection(kChatWith)
          .orderBy('date')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => MessagesModel.fromJson(doc.data()))
            .toList();
      });
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }
}
