import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/stories/presentation/widgets/status_custom_widget.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class StatusListView extends StatelessWidget {
  const StatusListView({
    required this.status,
    super.key});
  final  List<StatusModel>status;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
             itemBuilder: (context, index) =>
             StatusCustomWidget(status:AppCubit.get(context).allUserAddStatus, index: index,),
             separatorBuilder: (context, index) => Column(
               children: [
                 Container(
                   height: 1,
                   color: Colors.grey[300],
                   width: double.infinity,
                 ),
                 SizedBox(height: 10.h),
               ],
             ),
             itemCount: AppCubit.get(context).allUserAddStatus.length,
               );
}}