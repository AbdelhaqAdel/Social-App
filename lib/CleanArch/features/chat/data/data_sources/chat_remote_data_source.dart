import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> addMessage(String receiver, String message);

  Stream<List<MessagesModel>> getMessages(String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {

  @override
  Future<void> addMessage(String receiverId, String message) async {
    try {
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(uid)
          .collection(kAllChats)
          .doc(receiverId)
          .collection(kChatWith)
          .add(createMessage(message).toMap());

          await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(receiverId)
          .collection(kAllChats)
          .doc(uid)
          .collection(kChatWith)
          .add(createMessage(message).toMap());

    } catch (e) {
      throw Exception('Error adding message: $e');
    }
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
