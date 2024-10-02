import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/features/profile/presentation/widgets/edit_profile_buttons.dart';
import 'package:newapp/CleanArch/features/profile/presentation/widgets/user_image.dart';
class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key,required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Text('${userModel.name}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey
                  ),),],
              ),
               ),
            body:
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UserImage(),
                      SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${userModel.nickname}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[400],
                              fontSize: 15
                          )
                        ),
                        Text('${userModel.bio}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[400],
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h,),
                    const EditProfileAndLogout(),
                    SizedBox(height: 10.h,),                  
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
                      ],),]
                ),),),
          );
    
  }
}
