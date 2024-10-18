import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    required this.comment,
    super.key, required this.index});
  final List<Map<String,dynamic>>comment;
   final int index;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left:8.0,top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 20.sp,
              backgroundImage: NetworkImage('${comment[index]['userImage']}'),
            ),
            
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment:Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 8.w, right: 10.w, top: 0.h, bottom: 5.h),
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                     topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: AppColor.layoutBackgroundColor,
                  ),
                  child: CommentBody(comment: comment, index: index),
                ),
              ),
               Align(
                alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: Text(
                        DateFormat("hh:mm a").format(
                        DateTime.parse(comment[index]['date']) 
                     ),    style:  TextStyle(
                          color: AppColor.layoutBackgroundColor,
                        ),
                      ),
                  ),
                )
            ],
          ),
        ],
      ),
    );


  }
}

class CommentBody extends StatelessWidget {
  const CommentBody({
    super.key,
    required this.comment,
    required this.index,
  });

  final List<Map<String, dynamic>> comment;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
         top: 8, bottom: 15, right: 70, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(.5),width: 2),
              borderRadius: BorderRadius.circular(15,)
              ),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 children: [
                   Text(
                    '${comment[index]['user']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                    ),
               SizedBox(
                   width: 5.w,
                 ),
               const Icon(
               Icons.check_circle,
               color: Colors.blue,
               size: 15,
           ),
                 ],
               ),
             ),
           ),
      Container(
  constraints: const BoxConstraints(
    maxWidth: 200, 
  ),
  child: Text(
    '${comment[index]['comment']}',
    style: const TextStyle(
      color: Colors.white,
      height: 2,
      fontSize: 15,
    ),
    softWrap: true, 
  ),
)
   ],
      ),
    );
  }
}