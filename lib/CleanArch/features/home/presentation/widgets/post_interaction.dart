import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class PostInteraction extends StatelessWidget {
  const PostInteraction({super.key,
    required this.commentController,
    required this.index,
    required this.post,
  });
   final TextEditingController commentController;
   final int index;
   final PostModel post;

  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(
                '${userModel?.image
                  // userImage==''?AppCubit.get(context).userModel?.image:userImage
                  }'),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 150.w,
            child: TextFormField(
              style:  TextStyle(
                fontSize: 18.sp
              ),
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Write a comment',
                hintStyle:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
              ),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  AppCubit.get(context).addComment(
                      AppCubit.get(context).likes[index], value);
                  commentController.clear();
                }
              },
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                PostCubit.get(context)
                    .addLike(postIndex: index);
              },
              icon:  Stack(
                children:[ const Icon(Icons.favorite_border_outlined,
                    size: 27,
                    color:Colors.red,
                    ),
                    Icon(Icons.favorite,
                    size: 27,
                    color:post.isUserLike==true?Colors.red:Colors.transparent,
                    ),
                    ]
              )),
        ],
      );
  }
}