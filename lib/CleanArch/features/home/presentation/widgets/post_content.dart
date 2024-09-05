import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';

class PostContent extends StatelessWidget {
  const PostContent({super.key,
  required this.post,
  });
   final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                      Text(
                '${post.postText}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 17.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[400],
                    ),
              ),
              SizedBox(
                height: 10.h,
              ),
              post.postImage != null
                  ? SizedBox(
                      height: 200.h,
                      width: double.infinity,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        child: Image.network(
                          '${post.postImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox(),
             
      ],
    );
  }
}