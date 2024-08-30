import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class TextFormFeild extends StatelessWidget {
   const TextFormFeild({
       required this.messageController,
       required this.recieverModel,
       required this.controller,
    super.key});
      final TextEditingController messageController;
       final UserRegisterModel recieverModel;
      final ScrollController controller;
void scrollDown(){
    controller.jumpTo(1);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: messageController,
                              onSubmitted: (data) {
                                if (messageController.text.isNotEmpty) {
                                  AppCubit.get(context).addToUserChat(
                                    message: data,
                                    userId: recieverModel.uId,
                                  );
                                  messageController.clear();
                                  scrollDown();
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                  messageController.clear();
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
                          );
  }
}