import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';

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
         Container(
           height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.layoutBackgroundColor.withOpacity(.5),width: 2),
              borderRadius: BorderRadius.circular(15,)
              ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                         style:  TextStyle(color: AppColor.layoutBackgroundColor,
                         fontSize: 17,
                         fontWeight: FontWeight.bold
                         ),
                       ),
                       const Spacer(),
                        Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20.sp,
                ),
                     ],
                  ),
           ),
         )
    );
  }
}

