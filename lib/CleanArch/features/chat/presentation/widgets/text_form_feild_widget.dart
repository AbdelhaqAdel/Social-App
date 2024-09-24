import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class CustomTextFormField extends StatelessWidget {
   const CustomTextFormField({
       required this.messageController,
       required this.receiverModel,
       required this.controller,
       required this.formKey, 
    super.key});
      final TextEditingController messageController;
       final UserModel receiverModel;
      final ScrollController controller;
      final GlobalKey<FormState> formKey ;

       void scrollDown(){
         Future.delayed(const Duration(milliseconds: 100), () {
             controller.animateTo(
               controller.position.maxScrollExtent,
               duration: const Duration(milliseconds: 300),
               curve: Curves.easeOut,
             );
           });  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key:formKey ,
      child: Padding(
             padding: const EdgeInsets.all(10.0),
            child: SizedBox(
            height: MediaQuery.of(context).size.height/12,  
            child: TextField(
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.darkTextColor 
              ),  
              controller: messageController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                               onPressed: () {
                       if (messageController.text.isNotEmpty) {
                         ChatCubit.get(context).addToUserChat(
                           message: messageController.text,
                           receiver: receiverModel.uId,
                         );                  
                          messageController.clear();
}
                },
                  icon:  Icon(Icons.send,
                    size: 30.sp,
                    color: AppColor.layoutBackgroundColor,),),
                hintText: 'Send Message',
                hintStyle:Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
        ),
    );
  }
}