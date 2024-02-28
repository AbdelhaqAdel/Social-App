import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newapp/LayoutScreens/ChatLayoutScreen.dart';
import 'package:newapp/modules/UserScreens/UserLogin/LoginScreen.dart';
import 'package:newapp/shared/Constants/KeyConstants.dart';

import '../../../LayoutScreens/HomeScreen.dart';
import '../../../shared/Component/StaticComponent.dart';
import '../../../shared/Constants/KeyConstants.dart';
import '../../../shared/Constants/KeyConstants.dart';
import '../../../shared/Constants/KeyConstants.dart';
import '../../../shared/Cubit/cubit/app_cubit.dart';
import '../../../shared/network/local/CacheHelper.dart';
import '../UserLogin/LoginCubit/cubit/login_cubit.dart';

class RegisterScreen extends StatelessWidget {
  var regemailController = TextEditingController();
  var regpasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: ( context, state) => {
        if (State is shopAddUserSuccessState){
        NavigateAndFinish(context, ChatLyaout()),
          // }
  }
      },
      builder: ( context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              backgroundColor:Colors.transparent
            ),
            body: Form(
              key: formkey,
              child: ModalProgressHUD(
                inAsyncCall:cubit.isRegisLoading,
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
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: nameController,
                            // onChanged: (data){
                            //   nameController.text=data;
                            // },
                            keyboardType:TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'name can\'t be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText:'User name',
                              prefixIcon:Icon(Icons.person,),
                              suffixIcon: Icons.person !=null ? IconButton(onPressed: (){
                              },
                                icon: Icon(Icons.person,),
                              ):null,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: regemailController,
                            // onChanged: (data) {
                            //   regemailController.text = data;
                            // },
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
                            // onChanged: (data) {
                            //   regpasswordController.text = data;
                            // },
                            controller: regpasswordController,
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
                          TextFormField(
                            controller: phoneController,
                            // onChanged: (data){
                            //   phoneController.text=data;
                            // },
                            keyboardType:TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'phone can\'t be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText:'Phone',
                              prefixIcon:Icon(Icons.phone,),
                              suffixIcon: Icons.phone !=null ? IconButton(onPressed: (){
                              },
                                icon: Icon(Icons.phone,),
                              ):null,
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

                                    cubit.RegisterIsLoading();
                                    try {
                                    await  cubit.RegisterMethod(
                                      name: nameController.text,
                                      email: regemailController.text,
                                      password: regpasswordController.text,
                                      phone: phoneController.text,
                                      image: 'https://th.bing.com/th/id/R.581eb679a50357ed30ad0d7544081ec6?rik=54dcWNzgeTMHEg&pid=ImgRaw&r=0',
                                      bio:'Add to your bio',
                                      cover: 'https://th.bing.com/th/id/R.581eb679a50357ed30ad0d7544081ec6?rik=54dcWNzgeTMHEg&pid=ImgRaw&r=0',
                                       nickname: 'NickName',
                                    );
                                      ShowSnackBar(context, text: ('Register Succeed'));
                                      NavigateAndFinish(context, ChatLyaout());
                                    }on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        ShowSnackBar(context, text: ('The password provided is too weak.'));
                                        print('The password provided is too weak.');
                                      } else if (e.code == 'email-already-in-use') {
                                        ShowSnackBar(context, text: ('The account already exists for that email.'));
                                        print('The account already exists for that email.');
                                      }
                                      else {
                                        ShowSnackBar(context,
                                            text: ('${e.
                                            toString()} itsss errroooorrrr '));
                                        print('${e.toString()} itsss errroooorrrr ');
                                      }
                                      }
                                    cubit.RegisterIsLoading();
                                  }

                                },
                                child: Text('REGISTER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),)),
                          ),
                          Row(
                            children: [
                              Text(
                                'Are you have account?',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    NavigateTo(context, LoginSreen());
                                  },
                                  child: Text('Login now')),
                            ],
                          ),
                        ],
                      ),
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
