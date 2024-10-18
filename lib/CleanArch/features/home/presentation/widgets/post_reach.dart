import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';


class PostReach extends StatelessWidget {
  const PostReach({super.key,
      required this.index,
      required this.post,
  required this.cubitContext,
});
  final BuildContext cubitContext;
     final int index;
   final PostModel post;
  @override
  Widget build(BuildContext context) {
  
  return Row(
      children: [
        GestureDetector(
          onTap: () {
           PostCubit.get(context).getPostLikedUser(postIndex: index);
         },          
          child: FadeInUp(
            from: 50,
           delay: const Duration(milliseconds: 1000),
            child: Container(
                height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.layoutBackgroundColor.withOpacity(.5),width: 2),
              borderRadius: BorderRadius.circular(30,)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                     Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 18.sp,
                    ),
                     SizedBox(
                      width: 5.w,
                    ),
                    FadeInUp(
                      child: Text(
                        "${post.postLikes}",
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 13.sp,
                                  color: Colors.grey,
                                ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            PostCubit.get(context).getPostComments(postIndex: index);
          },
          child:  FadeInUp(
              from: 50,
           delay: const Duration(milliseconds: 1000),
            child: Container(
                  height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.layoutBackgroundColor.withOpacity(.5),width: 2),
                borderRadius: BorderRadius.circular(30,)
                ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    children: [
                      Icon(
                            Icons.comment,
                            color: Colors.grey[400],
                            size: 15.sp,
                          ),
                               SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        '${post.postComments}',
                       style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 13.sp,
                                  color: Colors.grey,
                                ),
                      )
                    ],
                  ),
              ),
            ),
          ),
          ),
        
      ],
    );
      
  }
}