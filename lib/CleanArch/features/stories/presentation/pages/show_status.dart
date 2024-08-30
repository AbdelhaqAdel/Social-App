import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/stories/presentation/widgets/view_status_custom_widget.dart';
import 'package:newapp/models/PostModel/status_model.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShowStatus extends StatefulWidget {
  const ShowStatus({super.key});

  @override
  State<ShowStatus> createState() => _ShowStatusState();
}

class _ShowStatusState extends State<ShowStatus> {
  var boardcontroller = PageController();
  bool islast = false;

  State<ShowStatus> createState() => _ShowStatusState();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        List<StatusModel>? statusByUser = cubit.allStatus;
        return Scaffold(
          body: Column(
            children: [
              Container(
                height: 690,

                color: Colors.transparent,
                child: ConditionalBuilder(
                  condition: AppCubit.get(context).allStatus.isNotEmpty,
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
                      if (index == statusByUser.length - 1) {
                        setState(() {
                          islast = true;
                        });
                      }
                      else {
                        setState(() {
                          islast = false;
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
                    itemBuilder: (context, index) => ViewStatusWidget(
                     status:  AppCubit.get(context).allStatus,index: index),
                    itemCount: AppCubit.get(context).allStatus.length,
                  ),
                  fallback: (context) => const Center(
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
                      width: 6.w,
                    ),
                    SmoothPageIndicator(
                      controller: boardcontroller,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                        dotHeight: 7.h,
                        dotWidth: 7.w,
                        spacing: 5,
                        expansionFactor: 4,
                      ),
                      count: AppCubit.get(context).allStatus.length,
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
                    const Spacer(),
                    CircularPercentIndicator(
                      animation: true,
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
                              AppCubit.get(context).allStatus.length == 1) {
                            AppCubit.get(context).allStatus.clear();
                            Navigator.pop(context);
                          } else {
                            boardcontroller.nextPage(
                              duration: const Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          }
                        },
                        child: islast ||
                                AppCubit.get(context).allStatus.length == 1
                            ? const Icon(
                                Icons.done,
                                size: 20,
                              )
                            : const Icon(Icons.arrow_forward_ios),
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
