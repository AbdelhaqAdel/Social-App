import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/posts_likes_component.dart';

class LikedUserList extends StatelessWidget {
  const LikedUserList({super.key,required this.likedUsers});
  final List<Map<String,dynamic>>likedUsers;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemBuilder: (context, index) =>
            PostsLikesWidget(index: index,likedUsers: likedUsers,),
    
        itemCount:likedUsers.length);
  }
}