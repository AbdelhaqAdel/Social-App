import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/all%20users/users_list_view.dart';

class UsersBuilder extends StatelessWidget {
  const UsersBuilder({super.key,});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit,ChatState>(builder:(context,state){
      if(GetUserSuccessState.allUsers.isNotEmpty){
        return UsersListView(
        users: GetUserSuccessState.allUsers, cubitContext: context,);
      }else if(state is GetAllMessagesErrorState){
        return const Center(child: Text('Error'),);
      }
      else{
        return const Center(child: CircularProgressIndicator(),);
      }
    });
  }
}