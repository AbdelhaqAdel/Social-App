import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/cubit/app_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
          if(state is AddPostState){
        GoRouter.of(navigatorKey.currentState!.context).push(AppRouter.kAddPost);
          }
        },
        builder:(context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            // appBar: AppBar(leading:const NotifyIconButton(),),
            backgroundColor:AppColor.layoutBackgroundColor,
            body:
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                SizedBox(
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
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color:AppColor.layoutBackgroundBottomColor,
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 80, sigmaY:80),
                    child: const SizedBox(),
                  ),
                ),
                cubit.screens[cubit.currentIndex],
                Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,right: 12,bottom: 3,),
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
                                color: AppColor.whiteColor,
                                width: 1.2,
                                style: BorderStyle.solid,
                              ),
                            ),

                            child:BottomNavigationBar(
                              backgroundColor: Colors.transparent,
                              selectedItemColor:AppColor.layoutBackgroundBottomColor,
                              elevation:1,
                              type: BottomNavigationBarType.fixed,
                              onTap: (index)
                              {
                                cubit.changeCurrentIndex(index);
                              },
                              currentIndex: cubit.currentIndex,
                              items:cubit.navBarItems,

                            ),
                         ),
                        ),
                      ),
                    ),
                  ],
                ) ,
              ],
            ),
       );
      },
    );
  }
}
