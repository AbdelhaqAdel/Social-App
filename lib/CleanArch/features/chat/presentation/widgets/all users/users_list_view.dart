import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/all_users_custom_widget.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({super.key,
  required this.users,
  required this.cubitContext,
});
  final List<UserModel>users;
  final BuildContext cubitContext;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: (){
                              ChatCubit.get(cubitContext).messages=[];
                              AppRouter.cubitContext=cubitContext;
                               GoRouter.of(cubitContext).push(AppRouter.kChatScreen,
                               extra: {
                                'userId': users[index].uId,
                                'receiver':users[index],
                               });
                          },
                          child: FadeInRight(
                            delay: Duration(milliseconds: index*150),
                            from: 100,
                            child: AllUsersWidget(user: users[index]))),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 13.h,
                    ),
                    itemCount: users.length,
                  );
                
  }
}