import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/utils/hive_services.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

abstract class IProfileDataSource{

  Future<UserModel>getUserData({required String uid});

}
class ProfileRemoteDataSource implements IProfileDataSource{
final user = FirebaseAuth.instance;

  @override
  Future<UserModel> getUserData({required uid}) async{
     UserModel? userData;
     await FirebaseFirestore.instance.collection(kUsers).doc(uid).get().then((value) {
        userData= UserModel.fromJson(json: value.data());
        userImage=userData?.image??'';
        HiveServices.saveDataToHive(HiveConstants.userDataBox,userData, HiveConstants.userDataBox);
     });
     return userData!;
  }



}