import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post%20reach/liked_user_list_view.dart';

class LikedUsersBuilder extends StatelessWidget {
  const LikedUsersBuilder({super.key,
});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit,PostState>(builder:(context,state){
      if(GetLikedUsersSuccessState.likedUsers.isNotEmpty){
        return LikedUserList(likedUsers: GetLikedUsersSuccessState.likedUsers);
      }
       else if(state is GetLikedUsersLoadingState){
        return const Center(child: CircularProgressIndicator());
       }
      else{
       return const Center(child: Text('No Likes yet',style: TextStyle(color: AppColor.whiteColor),));
      }
    }
     );
  }
}