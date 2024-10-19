import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/stories/presentation/manager/cubit/story_cubit.dart';
import 'package:newapp/CleanArch/features/stories/presentation/widgets/view_status_custom_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ShowStatus extends StatefulWidget {
  const ShowStatus({super.key});
  @override
  State<ShowStatus> createState() => _ShowStatusState();
}

class _ShowStatusState extends State<ShowStatus> {
  var boarderController = PageController();
  bool isLast = false;
  int currentIndex = 0;

 @override
Widget build(BuildContext context) {
  return BlocConsumer<StatusCubit, StatusState>(
    listener: (context, state) {},
    builder: (context, state) {
      StatusCubit cubit = StatusCubit.get(context);
      bool hasStatus = cubit.userStatus.isNotEmpty;
      return Scaffold(
        backgroundColor: hasStatus && currentIndex < cubit.userStatus.length
            ? Color(cubit.userStatus[currentIndex].statusColor!)
            : AppColor.layoutBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.userStatus.clear();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  if (hasStatus)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 27.sp,
                        backgroundImage: NetworkImage(
                          '${cubit.userStatus[0].userImage}',
                        ),
                      ),
                    ),
                  SizedBox(width: 8.w),
                  if (hasStatus)
                    Text(
                      '${cubit.userStatus[0].name}', 
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                    ),
                  const Spacer(),
                  if (hasStatus) 
                    Text(
                      'at ${DateTime.parse(cubit.userStatus[currentIndex].statusDate!).hour}:${DateTime.parse(cubit.userStatus[currentIndex].statusDate!).minute}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[300],
                        height: 1,
                        fontSize: 15,
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: ConditionalBuilder(
                    condition: hasStatus,
                    builder: (context) => PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                          isLast = (index == cubit.userStatus.length - 1);
                        });
                      },
                      controller: boarderController,
                      itemBuilder: (context, index) => ViewStatusWidget(
                        status: cubit.userStatus,
                        index: index,
                      ),
                      itemCount: cubit.userStatus.length,
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              if (hasStatus)
                Container(
                  color: Color(cubit.userStatus[currentIndex].statusColor!),
                  height: 91,
                  child: Row(
                    children: [
                      SizedBox(width: 6.w),
                      SmoothPageIndicator(
                        controller: boarderController,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                          dotHeight: 7.h,
                          dotWidth: 7.w,
                          spacing: 5,
                          expansionFactor: 4,
                        ),
                        count: cubit.userStatus.length,
                      ),
                      const Spacer(),
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 7000,
                        radius: 38,
                        lineWidth: 5,
                        percent: (currentIndex + 1) / cubit.userStatus.length,
                        progressColor: isLast ? Colors.pink[800] : Colors.pink[600],
                        circularStrokeCap: CircularStrokeCap.round,
                        onAnimationEnd: (){
                            if (isLast || cubit.userStatus.length == 1) {
                              cubit.userStatus.clear();
                              Navigator.pop(context);
                            } else {
                              boarderController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );}
                        },
                        center: FloatingActionButton(
                          onPressed: () {
                            if (isLast || cubit.userStatus.length == 1) {
                              cubit.userStatus.clear();
                              Navigator.pop(context);
                            } else {
                              boarderController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            }
                          },
                          child: isLast || cubit.userStatus.length == 1
                              ? const Icon(Icons.done, size: 20)
                              : const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
}