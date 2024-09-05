import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class PostInteraction extends StatelessWidget {
  const PostInteraction({super.key,
    required this.commentController,
    required this.index,

  });
   final TextEditingController commentController;
   final int index;

  @override
  Widget build(BuildContext context) {
    return  Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                          '${userImage==''?AppCubit.get(context).userModel?.image:userImage}'),
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
                          AppCubit.get(context)
                              .addLike(AppCubit.get(context).likes[index]);
                          AppCubit.get(context).changeLikeButtonColor(
                              AppCubit.get(context).likes[index]);
                        },
                        icon: const Icon(Icons.favorite,
                            size: 25,
                            color: // AppCubit.get(context).userLiked![AppCubit.get(context).likes[index]]!
                                Colors.red
                       
                            )),
                  ],
                );
  }
}