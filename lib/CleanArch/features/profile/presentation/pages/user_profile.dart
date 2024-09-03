import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/CleanArch/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:newapp/CleanArch/features/profile/presentation/widgets/user_fav_story_custom_widget.dart';
import 'package:newapp/CleanArch/features/profile/presentation/widgets/user_posts_followers_following_custom.dart';
import 'package:newapp/CleanArch/features/auth/presentation/pages/login_screen.dart';
import 'package:newapp/CleanArch/core/utils/widgets/static_component.dart';
import '../../data/models/user_model.dart';
import '../../../../core/utils/key_constants.dart';
import '../../../../../shared/Cubit/cubit/app_cubit.dart';
import '../../../../core/cache_helper.dart';


class USerProfile extends StatelessWidget {
  const USerProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
          if(state is shopGetUserSuccessState){
            uid=CacheHelper.getData('uid');
          }
        },
        builder:(context,state){
          var screenSize=MediaQuery.of(context).size;
          AppCubit cubit =AppCubit.get(context);
          UserModel ?userModel=cubit.userModel;
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Text('${userModel?.name}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey
                  ),
                  ),
                ],
              ),
               ),
            body:
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      SizedBox(
                        height:screenSize.height/3.5,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children:[
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: SizedBox(
                                width: double.infinity,
                                height:screenSize.height/4.5,
                                child: Card(
                                  elevation: 10,
                                  child: Image.network('${userModel?.cover}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor:HexColor('#13003b'),
                              radius: screenSize.width/8,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('${userModel?.image}'),
                                radius: screenSize.width/8.5,
                          ),
                            ),
                            ]
                        ),
                      ) ,
                    SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${userModel?.nickname}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[400],
                              fontSize: 15
                          )
                        ),
                        Text('${userModel?.bio}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[400],
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                   const UserData(),
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              cubit.Image = null;
                              cubit.coverImage=null;
                              NavigateTo(context, EditProfileScreen());
                            },
                            child: Container(
                                height: 30.h,
                                padding: EdgeInsets.all(7.r),
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10,),
                                  color: Colors.grey[500],
                                ),
                                child:
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children: [
                                    Text('Edit profile',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                    const SizedBox(width: 5,),

                                  ],
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w,),

                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              CacheHelper.removedata(key: 'uid');
                              NavigateAndFinish(context, LoginScreen());
                            },
                            child:  Container(
                                  height: 30.h,
                                  padding: const EdgeInsets.all(7),
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10,),
                                    color: Colors.grey[500],
                                  ),
                                  child:
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      Text('Log out',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontSize: 17.sp,

                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                   const FavStory(), 
                    Container(height: 0.5.h,color: Colors.grey[400],),
                    Row(
                      children: [
                        Expanded(
                          child:
                          IconButton(onPressed: (){
                            FirebaseMessaging.instance.subscribeToTopic('message');
                          },
                            iconSize: 35.sp,
                            icon: const Icon(Icons.square_sharp),
                            color:HexColor('#ea1a78'),
                          ),
                        ),
                        Container(
                          height: 26.h,
                          width: 0.5,
                          color: Colors.grey[300],
                        ),
                        Expanded(child:
                        IconButton(onPressed: (){
                          FirebaseMessaging.instance.unsubscribeFromTopic('message');
                        },
                          iconSize: 35.sp,
                          icon: const Icon(Icons.person_outline_rounded),
                          color:HexColor('#ea1a78'),
                        ),
                        ),

                      ],
                    ),
                  ]
                ),

              ),
            ),
          );
    },);
  }
}
