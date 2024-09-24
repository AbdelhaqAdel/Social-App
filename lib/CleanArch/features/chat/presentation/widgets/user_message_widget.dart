import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';

class UserMessageWidget extends StatelessWidget {
  const UserMessageWidget({
    required this.message,
    super.key});
  final MessagesModel message;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 5.h),
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: AppColor.layoutBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, right: 70, left: 8),
              child: Text(
                message.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 80,
            child: Text(
              DateFormat('HH:mm a').format(DateTime.parse(message.date)),
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        )
      ],
    );


  }
}