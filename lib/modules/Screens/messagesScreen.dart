import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/LayoutScreens/HomeScreen.dart';
import 'package:newapp/models/UserModel/UsersModel.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:newapp/shared/ListComponent/ListComponent.dart';
import 'package:newapp/shared/network/local/CacheHelper.dart';

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
             appBar: AppBar(title: Text('Chats'),
             backgroundColor: Colors.transparent,
             ),
             body: Container(
               padding: EdgeInsetsDirectional.all(6),
               child: ConditionalBuilder(
                 condition: cubit.allUsers.isNotEmpty,
                 builder: (context)=>ListView.separated(
                   itemBuilder: (context,index)=>
                      GetAllUsersWidget(users[index],context),
                   separatorBuilder: (BuildContext context, int index)=>
                   SizedBox(height: 13,),
                   itemCount: users.length,


                 ),
                 fallback: (context)=>Center(child: CircularProgressIndicator(),),
               )
             ),
           );
      },

    );
  }
}
