import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';

class OtherUserMessage extends StatelessWidget {
  const OtherUserMessage({
    required this.message,
    super.key});
  final MessagesModel message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 5.h),
            decoration:  const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: AppColor.otherMessage
            ),
            child:
                Padding(
                  padding:  const EdgeInsets.only(
                  top: 15, bottom: 15, right: 70, left: 8),      
                  child: Text(
                    message.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
          ),
        ),
          Align(
          alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.sp),
              child: Text(
              DateFormat('HH:mm a').format(DateTime.parse(message.date)),
                  style:  TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
            ),
          )
      ],
    );


  }
}
