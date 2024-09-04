import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/core/utils/widgets/custom_button.dart';
import 'package:newapp/CleanArch/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:newapp/CleanArch/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:newapp/CleanArch/features/auth/presentation/widgets/register_custom_widget.dart';
import 'package:newapp/CleanArch/features/auth/presentation/widgets/text_button_auth_account.dart';
import 'package:newapp/CleanArch/layout.dart';
import '../../../../core/utils/widgets/static_component.dart';


class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
       return BlocProvider(create: (context)=>AuthCubit(authRepository: getIt.get<AuthRepository>(), ),
    child: BlocConsumer<AuthCubit,AuthState>(
      listener: (context,state){
          if(state is RegisterSuccessState){
              NavigateAndFinish(context,const LayoutScreen());
                ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                  backgroundColor: Colors.green,
                 content: Text("Login success"),
              ),
            );
          }else if (state is RegisterErrorState) {
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
              backgroundColor:Colors.transparent
            ),
            body:
              Form(
           key: signUpFormKey,
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
                                    'Create new account',
                                    style: TextStyle(
                                      fontSize: 40.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  SizedBox(height: MediaQuery.of(context).size.height/25,),
                        RegisterFormWidget(
                            emailController:emailController ,
                            nameController: nameController,
                            passwordController:passwordController ,
                            phoneController:phoneController ,
                          ),
                            SizedBox(height: MediaQuery.of(context).size.height/25,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20.h),
                            child:state is RegisterLoadingState
                            ? Center(child: CircularProgressIndicator(color: AppColor.layoutBackgroundBottomColor ,))
                            : CustomButton(
                              backgroundColor: AppColor.layoutBackgroundColor,
                               width:MediaQuery.of(context).size.width,
                                text:'Sign up',
                                onPressed: () async{
                                    if (signUpFormKey.currentState!.validate()) {
                                      await AuthCubit.get(context).register(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name:nameController.text,
                                        phone: phoneController.text,
                                        image:'https://th.bing.com/th/id/R.581eb679a50357ed30ad0d7544081ec6?rik=54dcWNzgeTMHEg&pid=ImgRaw&r=0',
                                        bio:'Add to your bio',
                                        cover:'https://th.bing.com/th/id/R.581eb679a50357ed30ad0d7544081ec6?rik=54dcWNzgeTMHEg&pid=ImgRaw&r=0',
                                        nickname:'Nick name'
                                        );
                                    }
                                  },
                            ),),
                            Center(
                              child:TextButtonAuthAccount(
                                size: MediaQuery.of(context).size,
                                text:"Already have an account?",
                                textButton: "Sign in",
                                navigationScreen:const LayoutScreen(),
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
);  }
}
 