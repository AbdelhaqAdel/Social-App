import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';

class OtherUserMessage extends StatelessWidget {
  const OtherUserMessage({
    required this.message,
    super.key});
  final MessagesModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(15.sp),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.orange,
        ),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(
                  top: 30.h, bottom: 30.h, right: 70.w, left: 8.w),
              child: Text(
                message.message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
            ),
            const Text(
              'ssds',
              // '${DateTime.parse(message.date).timeZoneName}',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );


  }
}
