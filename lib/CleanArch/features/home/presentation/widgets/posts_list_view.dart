import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/all_posts_component.dart';

class PostsList extends StatelessWidget {
  const PostsList({
    required this.scaffoldKey,
    required this.posts,
    required this.cubitContext,
    super.key,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<PostModel> posts;
  final BuildContext cubitContext;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay : const Duration(milliseconds: 500),
      animate: true,
      child: ListView.separated(
        
        reverse: true,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var commentController = TextEditingController();
          return BuildPostsWidget(
                cubitContext: cubitContext,
                commentController: commentController,
                scaffoldKey: scaffoldKey,
                post: posts[index],
                index: index,
              );
        },
        separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
      ),
    );
  }
}
