import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';

abstract class IAuthDatasource{
  Future<void>signIn({required email,required password});
  Future<void>register({required email,required password});
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
  Future<void> register({required email, required password})async {
    // TODO: implement signUp From API
    // TODO save user data to local
    throw UnimplementedError();
  }
}