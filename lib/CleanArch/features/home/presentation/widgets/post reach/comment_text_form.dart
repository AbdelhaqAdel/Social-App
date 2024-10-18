import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';

class CommentTextFormField extends StatelessWidget {

   const CommentTextFormField({
      //  required this.messageController,
      //  required this.controller,
      //  required this.formKey, 
    super.key, required this.index});
      // final TextEditingController messageController;
      // final ScrollController controller;
      // final GlobalKey<FormState> formKey ;
      final int index;
      //  void scrollDown(){
      //    Future.delayed(const Duration(milliseconds: 100), () {
      //        controller.animateTo(
      //          controller.position.maxScrollExtent,
      //          duration: const Duration(milliseconds: 300),
      //          curve: Curves.easeOut,
      //        );
      //      });  }
  @override
  Widget build(BuildContext context) {
        GlobalKey formKey = GlobalKey<FormState>();

     TextEditingController messageController=TextEditingController();
    return Form(
      key:formKey ,
      child: Padding(
             padding: const EdgeInsets.all(10.0),
            child: SizedBox(
            height: MediaQuery.of(context).size.height/10,  
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
                         PostCubit.get(context).addComment(
                           newComment: messageController.text,
                           postIndex: index,
                         );                  
                          messageController.clear();
}
                },
                  icon:  Icon(Icons.send,
                    size: 30.sp,
                    color: AppColor.layoutBackgroundColor,),),
                hintText: 'Write a comment',
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