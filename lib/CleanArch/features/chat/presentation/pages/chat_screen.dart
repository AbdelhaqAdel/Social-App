import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/other_messsage_widget.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/user_message_widger.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import '../../../../../models/UserModel/UsersModel.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final UserRegisterModel recieverModel;
  ChatScreen({super.key, 
   required this.recieverModel
});
  TextEditingController messageController=TextEditingController();
  final ScrollController _controller = ScrollController();
  void scrollDownUsingArrow(){
    _controller.animateTo
      (
          _controller.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
           curve: Curves.fastEaseInToSlowEaseOut,
    );
  }
  void scrollDown(){
    _controller.jumpTo(1);

  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder:(context) {
      AppCubit.get(context).getMessages(recieverModel.uId??'');
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          List<MessagesModel>messagees = cubit.message;
        //  return StreamBuilder<QuerySnapshot>(
             // stream:
              //cubit.getMessagesUpdates(cubit.usetId),
            //  cubit.messages?.snapshots(),
              //builder: (BuildContext context, snapshot) {
               // if (snapshot.hasData) {
                  // List<MessagesModel> messageList=[];
                  // for(int i=0;i<snapshot.data!.docs.length;i++){
                  //   messageList.add(MessagesModel.fromJson(snapshot.data!.docs[i]));
                  // }
                  // print(snapshot.data!.docs[0]['text']);
                  return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          cubit.message = [];
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      automaticallyImplyLeading: false,
                      title:Text('${recieverModel.name}'),
                      centerTitle: true,
                      backgroundColor: AppColor.layoutBackgroundColor
                    ),
                    body: ConditionalBuilder(
                      condition:true, 
                      builder:(context)=> Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                             reverse: false,
                              controller: _controller,
                              itemBuilder: (context, index) =>
                              messagees[index].reciever == recieverModel.uId
                                  ? OtherUserMessage(message: messagees[index])
                                  : UserMessageWidget(message: messagees[index]),

                              itemCount: messagees.length,
                              separatorBuilder: (context, index) =>const SizedBox(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: messageController,
                              onSubmitted: (data) {
                                if (messageController.text.isNotEmpty) {
                                  cubit.addToUserChat(
                                    message: data,
                                    userId: recieverModel.uId??'',
                                  );
                                  messageController.clear();
                                  scrollDown();
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                  messageController.clear();
                                },
                                  icon:  Icon(Icons.send,
                                    size: 30.sp,
                                    color: Colors.deepOrange,),),
                                hintText: 'Send Message',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      fallback:(context)=> const Center(child: CircularProgressIndicator()),
                    ),
                  );
        },
      );
    });
  }
}
