import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/chat/presentation/pages/chat_screen.dart';
import 'package:newapp/models/PostModel/PostModel.dart';
import 'package:newapp/models/UserModel/UsersModel.dart';
import 'package:newapp/modules/Screens/showStatus.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import '../../models/MessagesModel/MessagesModel.dart';

Widget OtherMessageWidget({
  required MessagesModel message,
}) =>
    Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.orange,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 30, right: 70, left: 8),
              child: Text(
                '${message.message}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              'ssds',
              // '${DateTime.parse(message.date).timeZoneName}',
              style: TextStyle(
                color: Colors.white,
              ),
            )
            //Text('${message.time}'),
          ],
        ),
      ),
    );

Widget MeMessageWidget({
  required MessagesModel message,
}) =>
    Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Colors.deepOrange,
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 70, left: 8),
                child: Text(
                  '${message.message}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 80,
            child: Text(
              'ccccc',
              //'${message.date}',
              // DateFormat.jm().format(DateTime.now()),
              //'${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("14:15:00"))}',
              //'${DateTime.now().hour-4} : ${DateTime.now().minute+35}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        )
      ],
    );

Widget GetAllUsersWidget(
  UserRegisterModel user,
  BuildContext context,
) =>
    InkWell(
      onTap: () {
        // InkWell(
        //     onTap: (){
        //   cubit.ChangeChatIndex(users[index].uId!);
        //   cubit.getMessages(users[index].uId!);
        //
        // },
        // child:
        AppCubit.get(context).getMessages(user.uId!);
        NavigateTo(context, ChatScreen(recieverModel: user));
        },
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage('${user.image}'),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${user.name}',
                        //'${cubit.userModel?}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey[400], height: 1.5),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 17,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 30,
                    width: 240,
                    child: Text(
                      'last messagewwwwwwwwwwwwwwwwwwwwwwwwwww'
                      'wwwwwwwwwwwwwwwwwwwwwwwwwwww'
                      'wwwwwwwwwwwwwwwww',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          height: 1,
                          color: Colors.grey[500],
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  // Text(
                  //   '${DateTime.parse(post!.postDate!).year}-${DateTime.parse(post.postDate!).month}'
                  //       '-${DateTime.parse(post!.postDate!).day} at '
                  //       '${DateTime.parse(post!.postDate!).hour}:${DateTime.parse(post.postDate!).minute}',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .caption
                  //       ?.copyWith(height: 0.5,  color: Colors.grey[400],),
                  // ),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.list))
          ],
        ),
      ),
    );

Widget BuildStatusWidget(
  context,
  List<statusModel> status,
  int index,
) =>
    Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            GestureDetector(
              onTap: () {
                AppCubit.get(context).anotherGetStatus(
                    AppCubit.get(context).allUserAddStatus![index].uId);
                //  print(AppCubit.get(context).allStatus?.length);
                NavigateTo(context, ShowStatus());
                // print(AppCubit.get(context).allUserAddStatus![index].uId);
              },
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  height: 63,
                  width: 63,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      //shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 4)),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${status[index].image}'
                      //'https://th.bing.com/th/id/OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8?pid=ImgDet&rs=1'
                      //${post?.image}'
                      ),
                ),
              ]),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${status[index].name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.5),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text(
                  // 'at ${DateTime.parse(status.postDate!).hour}:${DateTime.parse(status.postDate!).minute}',
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .caption
                  //     ?.copyWith(height: 0.5),
                  // ),
                ],
              ),
            ),
          ]),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
        ],
      ),
    );
