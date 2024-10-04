import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_comment_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_like_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/create_post_usecase.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post_likes_show_dialog.dart';

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
            // PostCubit.get(context).getPostLikedUser(postIndex: index);
                showDialog<String>(
                    barrierColor: Colors.black.withOpacity(.3),
                    useSafeArea: true,
                    builder: (BuildContext context) => BlocProvider(
                create: (context) => PostCubit(
                        postRepository:getIt.get<PostRepository>(),postLikeRepo:getIt.get<PostLikeRepository>(),
                         postCommentRepo: getIt.get<PostCommentRepository>(),
                          createPostUseCase: getIt.get<CreatePostUseCase>()
                        )..getPostLikedUser(postIndex: index),
                child:   BlocConsumer<PostCubit,PostState>(
                     listener: (context, state) {},
                     builder: (context, state) {
                       return   PostLikesDialog(
                      cubitContext: cubitContext,
                      width: MediaQuery.of(context).size.width-20 ,
                    );
                     })), context: context);
         
         
         },          
          child: FadeInLeft(
delay: const Duration(milliseconds: 1000),
            from:400,            child: Row(
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
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: FadeInRight(
            delay: const Duration(milliseconds: 1000),
            from:400,
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
      ],
    );
      
  }
}