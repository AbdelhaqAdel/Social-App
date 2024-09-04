import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/widgets/custom_form_field.dart';
import 'package:newapp/CleanArch/features/auth/presentation/manager/cubit/auth_cubit.dart';

class RegisterFormWidget extends StatelessWidget {
  // final GlobalKey<FormState> signInFormKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const RegisterFormWidget({
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
    super.key});

  @override
  Widget build(BuildContext context) {
       var readCubit=context.read<AuthCubit>();
       var watchCubit=context.watch<AuthCubit>();
    return            
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            SizedBox(
             width: double.infinity,
            child: CustomFormField(
              sizedBoxHeight: 20,
                  hintTextFontSize: 25.0.sp,
               outLineBorderColor: AppColor.layoutBackgroundColor,
              focusedBorderColor: Colors.blue,
                backgroundColor: const Color(0xfffafafa),
              border:9.0,
              prefix:const Icon( Icons.email),
              controller: nameController,
              hintText: 'Name',
              keyboardType: TextInputType.text,
              validator: (value) {
                if(value!.isEmpty){
                  return 'please enter your name';
                }
                return null;
              },    
            ),
          ),
             SizedBox(
              width: double.infinity,
            child:
            CustomFormField(
              sizedBoxHeight: 20,
              controller:phoneController,
              border: 9.0,
              hintTextFontSize: 25.0.sp,
              outLineBorderColor:   AppColor.layoutBackgroundColor,
              focusedBorderColor: Colors.blue,
              backgroundColor:    const Color(0xfffafafa),
              prefix:const Icon(Icons.phone),
              hintText: 'phone',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if(value!.isEmpty){
                  return 'please enter your phone number';
                }
                return null;
              },                      
              )
          ),
          
       
            SizedBox(
             width: double.infinity,
            child: CustomFormField(
              sizedBoxHeight: 20,
                  hintTextFontSize: 25.0.sp,
               outLineBorderColor: AppColor.layoutBackgroundColor,
              focusedBorderColor: Colors.blue,
                backgroundColor: const Color(0xfffafafa),
              border:9.0,
              prefix:const Icon( Icons.email),
              controller: emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                return watchCubit.emailValidator(value);
              },
            ),
          ),
            SizedBox(
              width: double.infinity,
            child:
            CustomFormField(
              sizedBoxHeight: 20,
              controller:passwordController,
              border: 9.0,
              hintTextFontSize: 25.0.sp,
              outLineBorderColor:   AppColor.layoutBackgroundColor,
              focusedBorderColor: Colors.blue,
              backgroundColor:    const Color(0xfffafafa),
               isPassword: watchCubit.isPassword,
              prefix:const Icon(Icons.lock_rounded),
              hintText: 'Password',
              suffix: GestureDetector(
              child:watchCubit.isPassword
                   ? const Icon(Icons.visibility_off)
                   : const Icon(Icons.visibility),
                   onTap: (){
                  readCubit.passvisibility();
                  },
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
              return readCubit.passwordRegisValidator(value);
              },                      
              )
          ),
        ],
      );
    
  
  }
}