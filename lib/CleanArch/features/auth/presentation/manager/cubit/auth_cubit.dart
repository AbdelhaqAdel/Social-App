import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());
  static AuthCubit get(context)=>BlocProvider.of(context);
  final AuthRepository authRepository;



  String? passwordValidator(value) {
    if (value!.length < 8 ||
        !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])').hasMatch(value)) {
      return 'Password must be at least 8 characters with a mix of uppercase, lowercase, and numbers';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value!.isEmpty) {
      return 'Please enter your Email';
    } else if (!RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  bool isPassword=true;
  void passvisibility(){
    isPassword=!isPassword;
    emit(IsObsecurePassState());
}

  Future<void> login({
    required String email,
    required String password
}) async{
  emit(LoginLoadingState());
   final response=await authRepository.signIn(email: email,password: password);
    response.fold(
      (errMessage) {
        print(errMessage);
       emit(LoginErrorState(errMessage: errMessage));},
      (uid) {
        print('user id :  $uid');
         emit(LoginSuccessState(uid: uid));}
    );
  }

  void createUuser({
    required String name,
    required String email,
    required String uId,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname,
  }){
    UserModel ?registerModel=UserModel(
      name:name,email: email,uId:uid!,phone: phone,image: image,bio: bio,cover :cover,nickname: nickname);
    FirebaseFirestore.instance.collection(Kusers).doc(uId).set(registerModel.toMap()).then((value) {
    }).catchError((onError){
      print(onError);
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String bio,
    required String cover,
    required String nickname
  }) async{
    final user = FirebaseAuth.instance;
    await user.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      emit(RegisterSuccessState(value.user!.uid));
      CacheHelper.saveData(key: 'uid', value: value.user!.uid).then((value){
      });
      createUuser(name: name, email: email, 
      uId: value.user!.uid, phone:phone,
      image:image,bio:bio,cover: cover,
      nickname: nickname);
      print('user id : ${value.user!.uid}');
    }).catchError((onError){
      emit(RegisterErrorState());
    });
  }

  UserModel? userModel;
  void getUserData()async
  {
    emit(GetUserLoadingState());
   await FirebaseFirestore.instance.collection(Kusers).doc(CacheHelper.getData('uid')).get()
        .then((value) {
          userModel=UserModel.fromJson(value.data()!);
          emit(GetUserSuccessState());
    }).catchError((onError){
      print('getting user data error : ${onError.toString()}');
      emit(GetUserErrorState());
    });
  }
 
}
