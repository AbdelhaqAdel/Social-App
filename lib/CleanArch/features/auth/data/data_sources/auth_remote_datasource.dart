import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/utils/hive_services.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';

abstract class IAuthDatasource{
  Future<String>signIn({required email,required password});
  Future<RegisterModel>register({
   required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname    });
  Future<RegisterModel>getUserData({required String uid});

}
class RemoteDataSource implements IAuthDatasource{
final user = FirebaseAuth.instance;

  @override
  Future<String> signIn({required email, required password}) async{
    String? token;
    await user.signInWithEmailAndPassword(email: email, password: password).then((value){
      print('............${value.user?.uid}');
      token=value.user?.uid;
       CacheHelper.saveData(key: 'UID', value:value.user?.uid);
      });
      return token??'';
    }

  @override
  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname})async {
     RegisterModel? registerModel;
     await user.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      CacheHelper.saveData(key: 'UID', value: value.user!.uid);
      registerModel=RegisterModel(
      name:name,email: email,uId:uid,phone: phone,image: image,bio: bio,cover :cover,nickname: nickname);
      print(value.user!.uid);
      uid=value.user!.uid;
      createUuser(
      uId: value.user!.uid,
      registerModel: registerModel!,
      );
     });
     return registerModel!;
  }

    void createUuser({
       required String uId,
       required RegisterModel registerModel
  })async{
    await FirebaseFirestore.instance.collection(Kusers).doc(uId).set(registerModel.toMap());
    await FirebaseFirestore.instance.collection(Kusers).doc(uId).update({'uid':uId});
  }
  
  @override
  Future<RegisterModel> getUserData({required uid}) async{
     RegisterModel? userData;
     await FirebaseFirestore.instance.collection(Kusers).doc(uid).get().then((value) {
        userData= RegisterModel.fromJson(json: value.data());
        HiveServices.saveDataToHive(HiveConstants.userDataBox,userData, HiveConstants.userDataBox);
     });
     return userData!;
  }



}