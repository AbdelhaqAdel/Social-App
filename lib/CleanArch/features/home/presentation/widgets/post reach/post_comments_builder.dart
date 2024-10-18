import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post%20reach/post_comments_list_view.dart';

class CommentsBuilder extends StatelessWidget {
  const CommentsBuilder({super.key,
});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit,PostState>(builder:(context,state){
      if(GetPostCommentsSuccessState.postComments.isNotEmpty){
        return CommentsList(comments: GetPostCommentsSuccessState.postComments);
      }
       else if(state is GetPostCommentsLoadingState){
        return const Center(child: CircularProgressIndicator());
       }
      else{
       return const Center(child: Text('No comments yet',style: TextStyle(color: AppColor.whiteColor),));
      }
    }
     );
  }
}