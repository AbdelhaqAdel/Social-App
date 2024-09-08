import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/all_posts_component.dart';

class PostsList extends StatelessWidget {
  const PostsList({
    required this.scaffoldKey,
    required this.posts,
    super.key});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<PostModel>posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
             reverse: true,
             physics: const BouncingScrollPhysics(),
             shrinkWrap: true,
             itemBuilder: (context, index) {
               var commentController = TextEditingController();
               return BuildPostsWidget(
                 commentController: commentController,
                 scaffoldKey: scaffoldKey,
                 post:posts[index],
                 index: index,);
             },
             separatorBuilder: (context, index) =>
                 SizedBox(height: 3.h,),
             itemCount: posts.length
         );
  }
}