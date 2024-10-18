import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/all_posts_component.dart';

class PostsList extends StatelessWidget {
  const PostsList({
    required this.posts,
    required this.cubitContext,
    super.key,
  });

  final List<PostModel> posts;
  final BuildContext cubitContext;

  @override
  Widget build(BuildContext context) {
    return
       ListView.separated(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var commentController = TextEditingController();
          return FadeInUp(
            delay: Duration(milliseconds: index*50),
            from: 100,
            child: BuildPostsWidget(
                  cubitContext: cubitContext,
                  commentController: commentController,
                  post: posts[index],
                  index: index,
                ),
          );
        },
        separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
    );
  }
}
