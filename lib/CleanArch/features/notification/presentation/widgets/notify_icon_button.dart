import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/notification/presentation/widgets/notify.dart';
import 'package:newapp/CleanArch/features/notification/presentation/widgets/show_history_dialog.dart';


class NotifyIconButton extends StatefulWidget {
  const NotifyIconButton({super.key, required this.notificationNumber,});
  final int notificationNumber;

  @override
  State<NotifyIconButton> createState() => _NotifyIconButtonState();
}

class _NotifyIconButtonState extends State<NotifyIconButton> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children:[ IconButton(
          onPressed: () {
            ShowDialogFun.call(
              context: context,
              dialogWidget: RecentActivityDialog(cubitContext: context),
            ).then((value) {
              setState(() {
                isNotifyOpened=true;
              });
            });
          },
          icon: const FaIcon(FontAwesomeIcons.bell,color: AppColor.titleText,size: 28,),
        ),widget.notificationNumber>0 && !isNotifyOpened
       ? Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 9,
            backgroundColor: AppColor.defaultColor,
            child: Text('${widget.notificationNumber}',style: const TextStyle(color: AppColor.whiteColor),)),
        ):const SizedBox()
        
        ]
    );
  }
}
