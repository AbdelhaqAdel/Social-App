import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/messages_list_view.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({super.key, required this.receiverModel,
  required this.controller,
  required this.messageController,
});
  final UserModel receiverModel;
  final TextEditingController messageController;
  final ScrollController controller ;
   
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit,ChatState>(builder:(context,state){
      if(ChatCubit.get(context).messages.isNotEmpty){
        return MessagesListView(
        receiverModel: receiverModel, 
        controller: controller,
        messageController: messageController,
        messages: ChatCubit.get(context).messages,);
      }else if(state is GetAllMessagesErrorState){
        return  Center(child: Text('Start New Chat with your friend ${receiverModel.name}'),);
      }
      else{
        return const Center(child: CircularProgressIndicator(),);
      }
    });
  }
}