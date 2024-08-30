import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/other_messsage_widget.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/text_form_feild_widget.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/user_message_widget.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import '../../../profile/data/models/user_model.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final UserRegisterModel recieverModel;
  ChatScreen({super.key, 
   required this.recieverModel
});
  final TextEditingController messageController=TextEditingController();
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
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          // List<MessagesModel>messagees = cubit.message;
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
                        },
                        icon: const Icon(Icons.arrow_back_ios,color: AppColor.titleText,),
                      ),
                      automaticallyImplyLeading: false,
                      title:Text('${recieverModel.name}',
                      style: const TextStyle(
                        color: AppColor.titleText,
                      ),
                      ),
                      centerTitle: true,
                      backgroundColor: AppColor.layoutBackgroundColor
                    ),
                    body: ConditionalBuilder(
                      condition: cubit.message.isNotEmpty||state is GetAllMessagesSuccessState, 
                      builder:(context)=> Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                             reverse: false,
                              controller: _controller,
                              itemBuilder: (context, index) =>
                                //print('--------------${ cubit.message[index].reciever}');
                                cubit.message[index].reciever == recieverModel.uId
                                  ? OtherUserMessage(message:  cubit.message[index])
                                  : UserMessageWidget(message:  cubit.message[index]),
                              itemCount:  cubit.message.length,
                              separatorBuilder: (context, index) =>const SizedBox(),
                            ),
                          ),
                        TextFormFeild(
                          messageController:messageController,
                          recieverModel:recieverModel,
                          controller:_controller
                        )
                        ],
                      ),
                      fallback:(context)=> const Center(child: CircularProgressIndicator(
                       color: AppColor.defaultColor,
                      )),
                    ),
                  );
        },
      );
    });
  }
}
