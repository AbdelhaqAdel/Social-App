import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post_author_data.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post_content.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post_interaction.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post_reach.dart';
class BuildPostsWidget extends StatelessWidget {
  const BuildPostsWidget({
    required this.commentController,
    required this.scaffoldKey,
    required this.post,
    required this.index,
    super.key
    });
   final TextEditingController commentController;
   final GlobalKey<ScaffoldState> scaffoldKey;
   final PostModel post;
   final int index;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color:AppColor.postCardColor
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             AuthorData(post: post,),
              SizedBox(
                height: 17.h,
              ),
              PostContent(post: post,),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 0.4.h,
                color: HexColor('#13003b'),
              ),
              SizedBox(height: 5.h,),
           PostReach(index:index),
          PostInteraction(commentController: commentController,
          index: index,
          ),
             
              SizedBox(
                height: 7.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


