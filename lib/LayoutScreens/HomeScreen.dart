import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newapp/models/MessagesModel/MessagesModel.dart';
import 'package:newapp/shared/Constants/KeyConstants.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:newapp/shared/ListComponent/ListComponent.dart';

import '../models/UserModel/UsersModel.dart';

class ChatScreen extends StatelessWidget {


  UserRegisterModel? recieverModel;
  ChatScreen({
    this.recieverModel
});
 // CollectionReference messages = FirebaseFirestore.instance.collection(KMessagesCollection);
  TextEditingController messageController=TextEditingController();
  ScrollController _controller = ScrollController();
//  String userId='';
  //ChatScreen({super.key, required String userId});

  void ScrollDownUsingArrow(){
    _controller.animateTo
      (
          _controller.position.maxScrollExtent,
          duration: Duration(seconds: 1),
           curve: Curves.fastEaseInToSlowEaseOut,
    );
  }
  void ScrollDown(){
    _controller.jumpTo(1);

  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder:(context) {
    //  _controller.jumpTo(0);
      AppCubit.get(context).getMessages(recieverModel!.uId!);
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
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      automaticallyImplyLeading: false,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(KLogo,
                            height: 60,
                            width: 60,
                          ),
                          Text('ScholarChat'),
                        ],
                      ),
                      centerTitle: true,
                      backgroundColor: Colors.deepOrange,
                    ),
                    body: ConditionalBuilder(
                      condition:true, //AppCubit.get(context).message.isNotEmpty,
                      builder:(context)=> Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                             reverse: false,
                              controller: _controller,
                              itemBuilder: (context, index) =>
                              messagees[index].reciever == recieverModel?.uId
                                  ? OtherMessageWidget(message: messagees[index])
                                  : MeMessageWidget(message: messagees[index]),

                              itemCount: messagees.length,
                              separatorBuilder: (context, index) => SizedBox(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: messageController,
                              onSubmitted: (data) {
                                if (messageController.text.length > 0) {
                                  cubit.addToUserChat(
                                    message: data,
                                    userId: recieverModel!.uId!,
                                  );
                                  // messages.add({
                                  //   'text': data,
                                  //   KcreatedAt:DateFormat.jm().format(DateTime.now()),
                                  //   'id':cubit.remail,
                                  // });
                                  messageController.clear();
                                  ScrollDown();
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                  // print(snapshot.data!['text']);
                                  // messages.add({'text':data});
                                   // ScrollDown();
                                  messageController.clear();
                                },
                                  icon: Icon(Icons.send,
                                    size: 30,
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
                      fallback:(context)=> Center(child: CircularProgressIndicator()),
                    ),

                    // floatingActionButton: Padding(
                    //   padding: const EdgeInsets.only(bottom: 60.0),
                    //   child: FloatingActionButton(
                    //     // label: Icon(
                    //     //     Icons.arrow_circle_down
                    //     // ),
                    //     onPressed: () {
                    //       ScrollDownUsingArrow();
                    //     },
                    //     child: Icon(
                    //       Icons.arrow_circle_down
                    //     ),
                    //   ),
                    // ),
                  );
          //       }
          //       else {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     }
          // );
        },
      );
    });
  }
}
