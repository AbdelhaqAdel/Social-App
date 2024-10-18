import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/widgets/glass_box.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post%20reach/liked_users_builder.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post%20reach/post_comments_builder.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key, required this.title, required this.isLikes,  this.postIndex,
  });
  final bool isLikes;
  final int? postIndex;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12.0),
        child: GlassBox(
          widget: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height/1.4,
            child:  
                 Column(
                  children: [
                       Container(
                            height: 40.h,
                            padding: EdgeInsets.all(8.sp),
                            child:  Text(title,
                            style: TextStyle(color:AppColor.layoutBackgroundColor,fontSize: 20,fontWeight:FontWeight.bold),
                            ),
                          ),
                          Container(
                            height:2,
                            color: Colors.white,
                            ),
                          SizedBox(
                            height:MediaQuery.of(context).size.height/1.7 ,
                            child:isLikes?const LikedUsersBuilder()
                            : const CommentsBuilder()),
                         
                          //  !isLikes? CommentTextFormField(index: postIndex??0,)
                          //  :const SizedBox(),
                  ],
                ),
              
            
          ),
          color: Colors.white.withOpacity(.3),
          border: true,
          borderRadius: 28,
          x: 40,
          y: 40,
        ));
  }
}
