import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsers = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection(kUsers).get();
      for (var element in querySnapshot.docs) {
        if (element.data()['uid'] != uid) {
          allUsers.add(UserModel.fromJson(json: element.data()));
        }
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
    return allUsers;
  }
}
