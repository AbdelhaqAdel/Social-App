import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/message_builder.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/text_form_feild_widget.dart';
import '../../../profile/data/models/user_model.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, 
   required this.receiverModel
});
  final UserModel receiverModel;
  final TextEditingController messageController=TextEditingController();
  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> formKey = GlobalKey();
  void scrollDown(){
    scrollController.jumpTo(1);

  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder:(context) {
      return BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {},
              builder: (context, state) {
                      return Scaffold(
                          appBar: AppBar(
                            leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios,color: AppColor.titleText,),
                            ),
                            automaticallyImplyLeading: false,
                            title:Text('${receiverModel.name}',
                            style: const TextStyle(
                              color: AppColor.titleText,
                            ),
                            ),
                            centerTitle: true,
                            backgroundColor: AppColor.layoutBackgroundColor
                          ),
                          body: ListView(
                            children: [
                               SizedBox(
                                height:MediaQuery.of(context).size.height/1.28,
                                 child: MessageBuilder(receiverModel: receiverModel, 
                                  controller: scrollController,
                                   messageController: messageController,),
                               ),
                               CustomTextFormField(messageController: messageController,
                                receiverModel: receiverModel, 
                               controller: scrollController,
                               formKey: formKey,
                               ),

                            ],
                          ),
                        );
              },
            );
         });
  }
}
