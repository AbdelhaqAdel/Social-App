import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class PostsLikesWidget extends StatelessWidget {
  const PostsLikesWidget({
    required this.index,
    super.key});
 final int index;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(8.sp),
      width: double.infinity,
      child: Text(
        '${AppCubit.get(context).likedName[index]}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

