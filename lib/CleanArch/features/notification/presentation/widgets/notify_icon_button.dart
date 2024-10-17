import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/notification/presentation/widgets/recent_activity.dart';
import 'package:newapp/CleanArch/features/notification/presentation/widgets/show_history_dialog.dart';


class NotifyIconButton extends StatelessWidget {
  const NotifyIconButton({super.key, required this.notificationNumber,});
  final int notificationNumber;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children:[ IconButton(
          onPressed: () {
            ShowDialogFun.call(
              context: context,
              dialogWidget: RecentActivityDialog(cubitContext: context),
            );
          },
          icon: const FaIcon(FontAwesomeIcons.bell,color: AppColor.whiteColor,size: 32,),
        ),notificationNumber>0?
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 9,
            backgroundColor: AppColor.defaultColor,
            child: Text('$notificationNumber',style: const TextStyle(color: AppColor.whiteColor),)),
        ):const SizedBox()
        
        ]
    );
  }
}
