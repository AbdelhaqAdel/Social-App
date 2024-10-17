import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/features/stories/presentation/widgets/status_custom_widget.dart';

class StatusListView extends StatelessWidget {
  const StatusListView({
    required this.status,
    required this.cubitContext,
    super.key});
  final  List<Map<String,dynamic>>status;
  final BuildContext cubitContext;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
             itemBuilder: (context, index) =>
              FadeInRight(
                  delay: Duration(milliseconds: index*150),
                  from: 100,
                 child: GestureDetector(
                           onTap: () {
                 AppRouter.cubitContext=cubitContext;
                 GoRouter.of(context).push(AppRouter.kShowStatus,extra: status[index]['uId']);},
                           child: StatusCustomWidget(status:status, index: index,),
                 ),
               ),
             separatorBuilder: (context, index) => Column(
               children: [
                  SizedBox(height: 10.h),
                 Container(
                   height: .2,
                   color: Colors.grey[500],
                   width: double.infinity,
                 ),
                 SizedBox(height: 10.h),
               ],
             ),
             itemCount: status.length,
               );
}}