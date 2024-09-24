import 'package:flutter/cupertino.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/other_messsage_widget.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/user_message_widget.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key,
  required this.receiverModel,
  required this.controller,
  required this.messageController,
  required this.messages,
});
  final UserModel receiverModel;
  final List<MessagesModel>messages;
  final TextEditingController messageController;
  final ScrollController controller ;
   
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
             controller.animateTo(
               controller.position.maxScrollExtent,
               duration:  const Duration(milliseconds: 300),
               curve: Curves.easeOut,
             );
           });
    return   ListView.separated(
                   reverse: false,
                    controller: controller,
                    itemBuilder: (context, index) =>
                      messages[index].receiver == receiverModel.uId
                        ? OtherUserMessage(message:messages[index])
                        : UserMessageWidget(message:messages[index]),
                    itemCount:  messages.length,
                    separatorBuilder: (context, index) =>const SizedBox(),
                  );
  }
}