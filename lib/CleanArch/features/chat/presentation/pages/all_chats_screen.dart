import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/all_users_custom_widget.dart';
import 'package:newapp/models/UserModel/UsersModel.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class MessagesScreen extends StatelessWidget{
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(

         listener:(context,state){},
      builder: (context,state){
        AppCubit cubit=AppCubit.get(context);
        List<UserRegisterModel>users=cubit.allUsers;
           return Scaffold(
             backgroundColor: Colors.transparent,
             appBar: AppBar(title: Text('Chats',
             style:Theme.of(context).textTheme.titleMedium?.copyWith(
                   color: AppColor.titleText,
                   fontSize: 22.sp
                 ),
             ),
             backgroundColor: Colors.transparent,
             ),
             body: Container(
               padding: EdgeInsetsDirectional.all(6.sp),
               child: ConditionalBuilder(
                 condition: cubit.allUsers.isNotEmpty,
                 builder: (context)=>ListView.separated(
                   itemBuilder: (context,index)=>
                      AllUsersWidget(user:users[index]),
                   separatorBuilder: (BuildContext context, int index)=>
                   SizedBox(height: 13.h,),
                   itemCount: users.length,
                 ),
                 fallback: (context)=>const Center(child: CircularProgressIndicator(),),
               )
             ),
           );
      },

    );
  }
}
