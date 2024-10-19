import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/config/strings.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/app_images.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/features/on_boarding/presentation/pages/rive_baskground.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/models/data_model.dart';
import '../widgets/onBoarding_custom_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}
class _OnBoardingState extends State<OnBoarding> {
  bool isLast = false;
 bool isMiddle =false;
  List<boardingModel> boarding = [
    boardingModel(
        image: (AppImages.onBoardingImagesP2),
        title: 'VibeShare',
        body: AppStrings.onBoardingTextP2),
    boardingModel(
        image: (AppImages.onBoardingImagesP1),
        title: 'Chat and Connect Seamlessly',
        body: AppStrings.onBoardingTextP1),
    boardingModel(
        image: (AppImages.onBoardingImagesP3),
        title: 'Your Profile',
        body:AppStrings.onBoardingTextP3 ),
  ];

  var boarderController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //       GoRouter.of(context).pushReplacement(AppRouter.kLogin);
      //       },
      //       child: Text("Skip",style: TextStyle(
      //         fontSize: 15,
      //         color: AppColor.layoutBackgroundColor
      //       ),),
      //     ),
      //   ],
      // ),
     
      body: 
      RiveBackground(
        widget: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                       }
                      else if(index == boarding.length - 2)
                      {
                        setState(() {
                          isMiddle = true;
                        });
                      }
                      else{
                        setState(() {
                          isLast = false;
                         isMiddle = false;
                        });
                      }
                    },
                    controller: boarderController,
                    itemBuilder: (context, index) =>
                        buildBoarditem(boarding[index],context),
                    itemCount: boarding.length,
                  ),
                ),
                 SizedBox(
                  height: MediaQuery.of(context).size.height/14,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                        controller: boarderController,
                        effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: AppColor.defaultColor,
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 5,
                          expansionFactor: 4,
                        ),
                        count: boarding.length),
                    const Spacer(),
                    CircularPercentIndicator(
                       animation: true,
                       animationDuration: 1000,
                       radius: 40,
                       lineWidth: 6,
                       percent: isLast? 1:isMiddle? .7:.3,                      
                       progressColor:isLast? Colors.pink[800]:Colors.pink[600],
                       //backgroundColor: ,
                       circularStrokeCap: CircularStrokeCap.round,
                       center: Container(
                         height: 53.h,
                         width: 60.w,
                         decoration: const BoxDecoration(
                           color: Colors.pink,
                           shape: BoxShape.circle,
                         ),
                         child: FloatingActionButton(
                           shape:const StadiumBorder(),
                           backgroundColor: Colors.pink,
                           onPressed: () {
                              if (isLast) {
                              GoRouter.of(context).pushReplacement(AppRouter.kLogin);
                             } else {
                               boarderController.nextPage(
                                 duration: const Duration(
                                   milliseconds: 750,
                                 ),
                                 curve: Curves.fastLinearToSlowEaseIn,
                               );
                             }
                           },
                           child:  isLast
                                     ? const Icon(Icons.done,
                                   color: Colors.white,
                                    size: 35
                                 ):const Icon(Icons.arrow_forward_ios,
                                   color: Colors.white,
                                 ),
      
      
                         ),
                       ),
                     ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

