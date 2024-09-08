import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post_likes_showDialog.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class PostReach extends StatelessWidget {
  const PostReach({super.key,
      required this.index,
      required this.post,
  });
   final int index;
   final PostModel post;
  @override
  Widget build(BuildContext context) {
  return Row(
      children: [
        GestureDetector(
          onTap: () {
            AppCubit.get(context)
                .getLikedUsers(AppCubit.get(context).likes[index]);
                showDialog<String>(
                    context: context,
                    barrierColor: Colors.black.withOpacity(.3),
                    useSafeArea: true,
                    builder: (BuildContext context) => PostLikesDialog(
                      height: MediaQuery.of(context).size.height/2.5,
                      width: MediaQuery.of(context).size.width-20 ,
                    ));
          },          
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
              Text(
                "${post.postLikes}",
                style:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
              )
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
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
                "${AppCubit.get(context).commentNum[index]}",
               style:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
              )
            ],
          ),
        ),
      ],
    );
      
  }
}