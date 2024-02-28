import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isLoginLoading=false;

  void LoginIsLoading(){
    isLoginLoading=!isLoginLoading;
    emit(LoginIsloadingStateState());
  }
  bool isPassword=true;
  void showPassword(){
    isPassword=!isPassword;
    emit(LoginPasswordState());
  }
}
