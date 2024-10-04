import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostsLikesWidget extends StatelessWidget {
  const PostsLikesWidget({
    required this.index,
    required this.likedUsers,
    super.key});
 final int index;
  final List<Map<String,dynamic>>likedUsers;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(8.sp),
      width: double.infinity,
      child:
         Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage('${likedUsers[index]['userImage']}'),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                   Text(
                   '${likedUsers[index]['user']}',
                   style: const TextStyle(color: Colors.white),
                ),
                 ],
              )
  
      
    );
  }
}

