import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/utils/hive_services.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';

abstract class IAuthDatasource{
  Future<String>signIn({required email,required password});
  Future<String>register({
   required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname    });
  Future<RegisterModel>getUserData();

}
class RemoteDataSource implements IAuthDatasource{
final user = FirebaseAuth.instance;

  @override
  Future<String> signIn({required email, required password}) async{
    String? token;
    await user.signInWithEmailAndPassword(email: email, password: password).then((value){
      token=value.user?.uid;
       CacheHelper.saveData(key: 'UID', value:value.user?.uid);
      });
      return token??'';
    }

  @override
  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname})async {
     String? token;
     await user.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      token=value.user!.uid;
      CacheHelper.saveData(key: 'UID', value: value.user!.uid);
      RegisterModel registerModel=RegisterModel(
      name:name,email: email,uId:uid,phone: phone,image: image,bio: bio,cover :cover,nickname: nickname);
      createUuser(
      uId: value.user!.uid,
      registerModel: registerModel,
      );
     });
     return token??'';
  }

    void createUuser({
       required String uId,
       required RegisterModel registerModel
  })async{
    await FirebaseFirestore.instance.collection(Kusers).doc(uId).set(registerModel.toMap());
  }
  
  @override
  Future<RegisterModel> getUserData() async{
     RegisterModel? userData;
     await FirebaseFirestore.instance.collection(Kusers).doc(CacheHelper.getData('UID')).get().then((value) {
        userData= RegisterModel.fromJson(json: value.data());
        HiveServices.saveDataToHive(HiveConstants.userDataBox,userData, HiveConstants.userDataBox);
     });
     return userData!;
  }



}