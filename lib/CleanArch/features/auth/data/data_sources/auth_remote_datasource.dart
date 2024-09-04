import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

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
      UserModel registerModel=UserModel(
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
       required UserModel registerModel
  }){
    FirebaseFirestore.instance.collection(Kusers).doc(uId).set(registerModel.toMap()).then((value) {
    }).catchError((onError){});
  }

}