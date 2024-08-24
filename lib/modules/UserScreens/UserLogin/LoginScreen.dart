import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/layout.dart';
import 'package:newapp/modules/UserScreens/UserLogin/LoginCubit/cubit/login_cubit.dart';
import 'package:newapp/modules/UserScreens/UserRegister/RegisterScreen.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:newapp/shared/network/local/CacheHelper.dart';

import '../../../CleanArch/features/chat/presentation/pages/chat_screen.dart';
import '../../../shared/Constants/KeyConstants.dart';

class LoginSreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {
          if(state is shopLoginSuccessState){
            print('user id nn :${state.uid}');
            CacheHelper.saveData(key: 'uid', value: state.uid).then((value){
              NavigateAndFinish(context, LayoutScreen());
            });
          }
        },
        builder: (context, state) {
          AppCubit cubit= AppCubit.get(context);
         return Scaffold(
         //  backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailController,
                          onChanged: (data) {
                            cubit.remail = data;
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email can not bs null';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                            suffixIcon: Icons.email_outlined != null
                                ? IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.email_outlined,
                              ),
                            )
                                : null,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onChanged: (data) {
                            cubit.pass = data;
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password can not be null';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.remove_red_eye,
                            ),
                            suffixIcon: Icons.remove_red_eye != null
                                ? IconButton(
                              onPressed: () {
                                cubit.showPassword();
                              },
                              icon: Icon(
                                cubit.isPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            )
                                : null,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                          ),
                          child: TextButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  print(cubit.remail);
                                  print(cubit.pass);
                                  cubit.LoginIsLoading();
                                  cubit.GetUserData();
                                 // cubit.GetPosts();
                                  try {
                                   await cubit.LoginMethod(
                                     email: emailController.text,
                                     password: passwordController.text,

                                   );
                                    ShowSnackBar(context, text: ('Login Success'));
                                  // NavigateAndFinish(context, ChatLyaout());
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      ShowSnackBar(context, text:('No user found for that email.'));
                                      print('No user found for that email.');
                                    } else if (e.code == 'wrong-password') {
                                      ShowSnackBar(context, text:('Wrong password provided for that user.') );
                                      print('Wrong password provided for that user.');
                                    }
                                    else{
                                      ShowSnackBar(context, text: 'Something is errorr');
                                      print(e.toString());
                                    }
                                  }
                                  cubit.LoginIsLoading();
                                }

                              },
                              child: Text('LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),
                              )),
                        ),
                        Row(
                          children: [
                            Text(
                              'Are you dont have account?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  NavigateTo(context, RegisterScreen());
                                },
                                child: Text('Register now')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );

  }

}
