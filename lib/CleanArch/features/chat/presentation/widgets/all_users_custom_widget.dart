import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/chat/presentation/pages/chat_screen.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class AllUsersWidget extends StatelessWidget {
  const AllUsersWidget({
    required this.user,
    super.key});
    final UserRegisterModel user;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
       // AppCubit.get(context).message = [];
        AppCubit.get(context).getMessages(user.uId);
          print('all message ${user.uId}');
        NavigateTo(context, ChatScreen(recieverModel: user));
        },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26.sp,
            backgroundImage: NetworkImage('${user.image}'),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${user.name}',
                      //'${cubit.userModel?}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey[400], height: 1.5),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 17,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: 30,
                  width: 240,
                  child: Text(
                    'last message',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.h,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400
                        ),
                  ),
                ),
                // Text(
                //   '${DateTime.parse(post!.postDate!).year}-${DateTime.parse(post.postDate!).month}'
                //       '-${DateTime.parse(post!.postDate!).day} at '
                //       '${DateTime.parse(post!.postDate!).hour}:${DateTime.parse(post.postDate!).minute}',
                //   style: Theme.of(context)
                //       .textTheme
                //       .caption
                //       ?.copyWith(height: 0.5,  color: Colors.grey[400],),
                // ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.list))
        ],
      ),
    );

  }
}