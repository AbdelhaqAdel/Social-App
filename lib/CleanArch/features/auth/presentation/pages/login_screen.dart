import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/utils/widgets/custom_button.dart';
import 'package:newapp/CleanArch/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:newapp/CleanArch/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:newapp/CleanArch/features/auth/presentation/pages/register_screen.dart';
import 'package:newapp/CleanArch/features/auth/presentation/widgets/form_custom_widget.dart';
import 'package:newapp/CleanArch/features/auth/presentation/widgets/text_button_auth_account.dart';
import 'package:newapp/shared/Notification/notification_model.dart';
import 'package:newapp/shared/Notification/notification_services.dart';


class LoginScreen extends StatelessWidget {
 final GlobalKey<FormState> signInFormKey = GlobalKey();
   final TextEditingController emailController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();
    LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AuthCubit(authRepository: getIt.get<AuthRepository>(), ),
    child: BlocConsumer<AuthCubit,AuthState>(
      listener: (context,state){
          if(state is LoginSuccessState){
             ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                backgroundColor:Colors.green,
                 content: Text("Login success"),
              ),
            );
            sendNotification(notification: NotificationModel(title: 'Welcome back',body: 'Login Success'),fcmToken: fcmToken);
             AuthCubit.get(context).getUserData(uid:state.uid);
             GoRouter.of(context).pushReplacement(AppRouter.kLayout);
          }else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
               backgroundColor: AppColor.layoutBackgroundBottomColor,
                content: Text(state.errMessage.toString()),
              ),
            );
          }
        },
        builder: (context, state) {
         return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body:
                Form(
          key: signInFormKey,
           child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Padding(
                              padding: EdgeInsets.fromLTRB(0, 20.h, 0, 40.h),
                              child:  Text(
                                    'Login to your account',
                                    style: TextStyle(
                                      fontSize: 40.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  SizedBox(height: MediaQuery.of(context).size.height/11,),
                        FormWidget(
                          emailController: emailController, 
                          passwordController: passwordController,
                        ),
                            SizedBox(height: MediaQuery.of(context).size.height/11,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20.h),
                            child:state is LoginLoadingState
                            ? Center(child: CircularProgressIndicator(color: AppColor.layoutBackgroundBottomColor ,))
                            : CustomButton(
                              backgroundColor: AppColor.layoutBackgroundColor,
                               width:MediaQuery.of(context).size.width,
                                text:'Login',
                                onPressed: () async{
                                    if (signInFormKey.currentState!.validate()) {
                                      await AuthCubit.get(context).login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                    }
                                  },
                            ),),
                            Center(
                              child:TextButtonAuthAccount(
                                size: MediaQuery.of(context).size,
                                text:"Don't have an account",
                                textButton: "Sign up",
                                navigationScreen: RegisterScreen(),
                              )
                       )
                          ])),
                ),
              ],
            ),
                 ),
         ),
          );
        },
      )
    );
  }

}
