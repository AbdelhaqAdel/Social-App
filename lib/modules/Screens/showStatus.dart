import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/models/PostModel/PostModel.dart';
import 'package:newapp/modules/Screens/StatusScreen.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/Component/StaticComponent.dart';
import '../../shared/Styles/themes.dart';

class ShowStatus extends StatefulWidget {
  @override
  State<ShowStatus> createState() => _ShowStatusState();
}

class _ShowStatusState extends State<ShowStatus> {
  var boardcontroller = PageController();
  bool islast = false;

  @override
  State<ShowStatus> createState() => _ShowStatusState();

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        List<statusModel>? statusByUser = cubit.allStatus;
        return Scaffold(
          // appBar: AppBar(
          //   leading:

          //   actions: [
          //
          //   ],
          // ),
          body: Column(
            children: [
              Container(
                // width: double.infinity,
                height: 690,
                color: Colors.transparent,
                child: ConditionalBuilder(
                  condition: AppCubit.get(context).allStatus?.length != 0,
                  builder: (context) =>
                      // ListView.separated(
                      //   scrollDirection: Axis.horizontal,
                      //   itemBuilder:(context,index)=> BuildShowStatusByUser(AppCubit.get(context).allStatus, context,index),
                      //   separatorBuilder: (context,index)=>Container(width: 10,),
                      //   itemCount: AppCubit.get(context).allStatus!.length,
                      //
                      // ),
                      PageView.builder(
                    onPageChanged: (index) {
                      if (index == statusByUser!.length - 1) {
                        setState(() {
                          islast = true;
                        });
                      }

                      else {
                        setState(() {
                          islast = false;
                          //ismiddle = false;
                        });
                      }
                      // if(DateTime.parse(AppCubit.get(context).allStatus![index].postDate!).hour==DateTime.parse(DateTime.now().toString()).hour){
                      // setState(() {
                      // AppCubit.get(context).allStatus![index].toMap().clear();
                      // });
                      // }

                      // else if(index == boarding.length - 2)
                      // {
                      // setState(() {
                      // ismiddle = true;
                      // });
                      // }
                    },
                    controller: boardcontroller,
                    itemBuilder: (context, index) => BuildShowStatusByUser(
                        AppCubit.get(context).allStatus, context, index),
                    itemCount: AppCubit.get(context).allStatus!.length,
                    //statusByUser?.length,
                    //AppCubit.get(context).allStatus?.length,
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              Container(
                color: Colors.red,
                height: 91,
                child: Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    SmoothPageIndicator(
                      controller: boardcontroller,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                        dotHeight: 7,
                        dotWidth: 7,
                        spacing: 5,
                        expansionFactor: 4,
                      ),
                      count: AppCubit.get(context).allStatus!.length,
                    ),
                    // islast? GestureDetector(
                    //   onTap: (){
                    //     AppCubit.get(context).allStatus?.clear();
                    //     Navigator.pop(context);
                    //     },
                    //   child: Container(
                    //     // height: 40,
                    //     // width: 80,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color:Colors.pink,
                    //     ),
                    //     child: Center(child: Text('Login',
                    //       style: TextStyle(
                    //         color:Colors.white,
                    //       ),
                    //     )),
                    //   ),
                    // ):SizedBox(),
                    // SizedBox(width: 250,),
                    Spacer(),
                    CircularPercentIndicator(
                      animation: true,
                      // addAutomaticKeepAlive: true,
                      // animateFromLastPercent: true,
                      animationDuration: 1000,
                      radius: 38,
                      lineWidth: 5,
                      percent: islast ? 1 : .7,
                      progressColor:
                          islast ? Colors.pink[800] : Colors.pink[600],
                      //backgroundColor: ,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: FloatingActionButton(
                        onPressed: () {
                          if (islast ||
                              AppCubit.get(context).allStatus!.length == 1) {
                            AppCubit.get(context).allStatus?.clear();
                            Navigator.pop(context);
                          } else {
                            boardcontroller.nextPage(
                              duration: Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          }
                        },
                        child: islast ||
                                AppCubit.get(context).allStatus!.length == 1
                            ? Icon(
                                Icons.done,
                                size: 20,
                              )
                            : Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget BuildShowStatusByUser(
  List<statusModel>? status,
  context,
  index,
) =>
    Stack(
      children:[
        Container(
          // height: 700,
          // width: 400,
          child: status?[index].postImage != null
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Expanded(
                    child: Card(
                      child: Image.network('${status?[index].postImage}'),
                    ),
                  ),
                  
                  Text(
                    '${status?[index].postText}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ])
              : Container(
                 color: Colors.red,
                  // height: 400,
                  //  width: 400,
                 // color: status?[index].color,
                  child: Center(
                    child: Text('${status?[index].postText}'),
                  ),
                )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).allStatus?.clear();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).allStatus![index].image}'),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${AppCubit.get(context).allStatus![index].name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 20),
                    ),
                    // SizedBox(
                    //   width: 190,
                    // ),
                    // IconButton(
                    //     onPressed: () {
                    //       print(AppCubit.get(context).allStatus?.length);
                    //       print(AppCubit.get(context).allStatus![0].postText);
                    //     },
                    //     icon: Icon(Icons.add)),
                  ],
                ),
              ),
              Text(
              'at ${DateTime.parse(status![index].postDate!).hour}:${DateTime.parse(status[index].postDate!).minute}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                color: Colors.black,
                  height:1,
                fontSize: 15

              ),
              ),
            ],
          ),
        ),
       // Text('${status?[index].postDate}'),
      ]
    );
