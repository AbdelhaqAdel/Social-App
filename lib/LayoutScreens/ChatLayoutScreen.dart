import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Constants/KeyConstants.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

import '../modules/Screens/AddPostScreen.dart';

class ChatLyaout extends StatelessWidget {
  const ChatLyaout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
          if(state is AddPostIndexState){
            NavigateTo(context, AddPostScreen());
          }
          // else if(state is shopGetUserSuccessState){
          //  // AppCubit.get(context).GetUserData(token: uid);
          //   print('uiiiidddd : ${uid}');
          // }
        },
        builder:(context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            backgroundColor:HexColor('#13003b'),
            //Color(0xFF17203A),

            // appBar: AppBar(title: Text('Chat App'),
            // backgroundColor: Colors.deepOrange,
            // ),
            body:
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(

                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor:HexColor('#f16ba8'),
                              radius: 40,
                            ),
                          ),
                          // Spacer(),
                           // Row(
                           //    mainAxisAlignment: MainAxisAlignment.start,
                           //   // crossAxisAlignment: CrossAxisAlignment.center,
                           //    children: [
                           //      Container(
                           //        width: 150,
                           //        height: 300,
                           //        //height: double.infinity,
                           //        decoration: BoxDecoration(
                           //          //shape: BoxShape.circle,
                           //          color: Colors.lightGreen ,
                           //        ),
                           //      ),
                           //      // Container(
                           //      //   width: 100,
                           //      //   height: double.infinity,
                           //      //   decoration: BoxDecoration(
                           //      //     //shape: BoxShape.circle,
                           //      //     color: Colors.white ,
                           //      //   ),
                           //      // ),
                           //      // Container(
                           //      //   width: 50,
                           //      //   height: double.infinity,
                           //      //   decoration: BoxDecoration(
                           //      //     //shape: BoxShape.circle,
                           //      //     color: Colors.black ,
                           //      //   ),
                           //      // ),
                           //    ],
                           //  ),

                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color:HexColor('#ea1a78'),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 80, sigmaY:80),
                    child: SizedBox(),
                  ),
                ),
                cubit.Screens[cubit.currentIndex],
                Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,right: 12,bottom: 3,),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 100,
                                sigmaY:100,
                                tileMode: TileMode.clamp
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.2,
                                  style: BorderStyle.solid,
                                ),
                              ),

                              child:BottomNavigationBar(
                                backgroundColor: Colors.transparent,
                                selectedItemColor:HexColor('#ea1a78'),
                                elevation:1,
                                // mouseCursor:MouseCursor.uncontrolled,
                                type: BottomNavigationBarType.fixed,
                                onTap: (index)
                                {
                                  cubit.ChangeCurrentIndex(index);
                                },
                                //selectedItemColor: Colors.deepOrange,
                                currentIndex: cubit.currentIndex,
                                items:cubit.navBarItems,

                              ),
                              // BottomNavigationBar(
                              //   currentIndex: cubit.currentIndex,
                              //   onTap: (index){
                              //     cubit.ChangeBottomNavBar(index);
                              //   },
                              //   type: BottomNavigationBarType.fixed,
                              //   items: cubit.bottomItems,
                              //   //fixedColor: Colors.black,
                              //   // selectedItemColor: HexColor('#d4088b'),
                              //   // backgroundColor: Colors.white,
                              //   elevation: 0,
                              // ),
                              // cubit.Screens[cubit.currentIndex],
                              // bottomNavigationBar:
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) ,
              ],
            ),

            // BottomNavigationBar(
            //   currentIndex: cubit.currentIndex,
            //   onTap: (index){
            //     cubit.ChangeBottomNavBar(index);
            //   },
            //   type: BottomNavigationBarType.fixed,
            //   items: cubit.bottomItems,
            //   //fixedColor: Colors.black,
            //   // selectedItemColor: HexColor('#d4088b'),
            //   // backgroundColor: Colors.white,
            //   elevation: 0,
            // ),
            // cubit.Screens[cubit.currentIndex],
            // bottomNavigationBar: BottomNavigationBar(
            //   type: BottomNavigationBarType.fixed,
            //      onTap: (index)
            // {
            //     cubit.ChangeCurrentIndex(index);
            //   },
            //   selectedItemColor: Colors.deepOrange,
            //   currentIndex: cubit.currentIndex,
            //   items:cubit.navBarItems,
            //
            // ),
          );
    },
    );
  }
}
