import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:newapp/LayoutScreens/HomeScreen.dart';
import 'package:newapp/models/PostModel/PostModel.dart';
import 'package:newapp/models/UserModel/UsersModel.dart';
import 'package:newapp/modules/Screens/showStatus.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

import '../../models/MessagesModel/MessagesModel.dart';
import '../../modules/Screens/ShowUsersLikedPosts/ShowUsersLikedPosts.dart';

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
                            .bodyText1
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
                      style: Theme.of(context).textTheme.caption?.copyWith(
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

Widget BuildPostsWidget({
  required TextEditingController commentController,
  GlobalKey<ScaffoldState>? ScaffoldKey,
  context,
  PostModel? post,
  int? index,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: HexColor('#c1cdcd').withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage('${post?.image}'),
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
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post?.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Colors.grey[400], height: 1.5),
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
                        Text(
                          '${DateTime.parse(post!.postDate!).year}-${DateTime.parse(post.postDate!).month}'
                          '-${DateTime.parse(post!.postDate!).day} at '
                          '${DateTime.parse(post!.postDate!).hour}:${DateTime.parse(post.postDate!).minute}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 0.5,
                                color: Colors.grey[400],
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.list))
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                '${post.postText}',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[400],
                    ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 0.5,
                          onPressed: () {},
                          child: Text(
                            'Alfyyy',
                            style: TextStyle(
                              color: HexColor('#13003b'),
                            ),
                          ),
                        )),
                    Container(
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'flutter developer',
                          style: TextStyle(
                            color: HexColor('#13003b'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              post.postImage != null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        child: Image.network(
                          '${post.postImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 0.4,
                color: HexColor('#13003b'),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AppCubit.get(context)
                          .getLikedUsers(AppCubit.get(context).likes[index]);
                      NavigateTo(context, ShowUserLikedPosts());
                    },
                    // {
                    //   print(AppCubit.get(context).isBottomSheetShown);
                    //
                    //   if (AppCubit.get(context).isBottomSheetShown) {
                    //     Navigator.pop(context);
                    //     AppCubit.get(context).isBottomSheetShown = false;
                    //     print(AppCubit.get(context).isBottomSheetShown);
                    //   } else
                    //     // if(AppCubit.get(context).likedName
                    //     //   .length!=[])
                    //   {
                    //     AppCubit.get(context).getLikedUsers(
                    //         AppCubit.get(context).likes[index]);
                    //     //}
                    //
                    //     ScaffoldKey?.currentState
                    //         ?.showBottomSheet((context) => Container(
                    //               height: 200,
                    //               width: double.infinity,
                    //               color: Colors.red,
                    //               child: ConditionalBuilder(
                    //                 condition:
                    //               //    AppCubit.get(context).state is !GetPostsLikesLoadingState,
                    //               AppCubit.get(context).likedName.isNotEmpty,
                    //                 builder: (context) => ListView.separated(
                    //                     itemBuilder: (context, index) =>
                    //                         UserLikedWidget(index, context),
                    //                     separatorBuilder: (context, index) =>
                    //                         SizedBox(
                    //                           height: 15,
                    //                         ),
                    //                     itemCount: AppCubit.get(context)
                    //                         .likedName
                    //                         .length),
                    //                 fallback: (context) =>
                    //                     Center(child: CircularProgressIndicator(color: Colors.white,),),
                    //               ),
                    //             ))
                    //         .closed
                    //         .then((value) {
                    //       AppCubit.get(context).isBottomSheetShown = false;
                    //       // AppCubit.get(context).changeBottomSheetState;
                    //     });
                    //     AppCubit.get(context).isBottomSheetShown = true;
                    //     //                     AppCubit.get(context).changeBottomSheetState;
                    //   }
                    //   //isBottomSheetShown=true;
                    //
                    //   //  AppCubit.get(context).getLikesByName(AppCubit.get(context).likes[index]);
                    // },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${AppCubit.get(context).likesNum[index!]}",

                            //"${AppCubit.get(context).likesNum[index!]}",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.comment,
                                color: Colors.grey[400],
                                size: 15,
                              )),
                          Text(
                            "${AppCubit.get(context).commentNum[index]}",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: Colors.grey[400],
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel?.image}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Write a comment',
                          hintStyle:
                              Theme.of(context).textTheme.caption?.copyWith(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                        ),
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            AppCubit.get(context).addComment(
                                AppCubit.get(context).likes[index!], value);
                            commentController.clear();
                          }
                        },
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .addLike(AppCubit.get(context).likes[index!]);
                          AppCubit.get(context).changeLikeButtonColor(
                              AppCubit.get(context).likes[index]);
                        },
                        icon: Icon(Icons.favorite_border,
                            size: 25,
                            color: // AppCubit.get(context).userLiked![AppCubit.get(context).likes[index]]!
                                Colors.red
                            //:Colors.white,
                            // color:
                            // AppCubit.get(context).isLiked.forEach((element) {
                            //   if(element== AppCubit.get(context).likes[index]) Colors.red;
                            // })
                            // // AppCubit.get(context).isLiked[index]
                            // //     ? Colors.red
                            // //     :
                            // Colors.white,
                            )),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
      ),
    );

Widget UserLikedWidget(int index, context) => Container(
      width: 80,
      height: 40,
      color: Colors.black,
      child: Text(
        '${AppCubit.get(context).likedName[index]}',
        style: TextStyle(color: Colors.white),
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
                        .bodyText1
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
