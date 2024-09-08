import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';
import 'package:newapp/CleanArch/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());
  static AuthCubit get(context)=>BlocProvider.of(context);
  final AuthRepository authRepository;



  String? passwordRegisValidator(value) {
    if (value!.isEmpty) {
      return 'Please enter your Email';
    } else if (value!.length < 8 ||
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
       emit(LoginErrorState(errMessage: errMessage.message));},
      (uid) {
         emit(LoginSuccessState(uid: uid));}
    );
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
      emit(RegisterLoadingState());
    final response=await authRepository.signUp
    (name: name, email: email, password: password,
     phone: phone, image: image, bio: bio, cover: cover,
      nickname: nickname);
      response.fold((errMessage)=>emit(RegisterErrorState(errMessage: errMessage.message)),
       (r) { 
        print('user dataaaa_---${userModel?.name}');
        emit(RegisterSuccessState(uid: uid));},
       );
  }

  Future<void> getUserData({required String uid})async{
   emit(GetUserDataLoadingState());
  final response=await authRepository.getUserProfile(uid: uid); 
  response.fold((errMessage) => emit(GetUserDataErrorState(errMessage: errMessage.message)),
   (userData)=> emit(GetUserDataSuccessState(userData: userData))
  );}
}
