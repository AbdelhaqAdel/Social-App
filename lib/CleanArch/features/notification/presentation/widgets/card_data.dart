import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/notification/data/NotificationModelAndAdabpter/notify_model.dart';

class CardData extends StatelessWidget {
  const CardData({super.key,required this.notify});
  final NotifyModel notify;

  @override
  Widget build(BuildContext context) {
    return  Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          notify.notifyTitle??'',
                          maxLines: 1,
                          style:  TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColor.layoutBackgroundColor,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(notify.notifyBody??'',
                        style:  TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.layoutBackgroundColor,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines:2,
                      ),
                       const SizedBox(height: 5),
                      Container(
                        height: 35.h,
                        width:200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color: AppColor.defaultColor.withOpacity(.2),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.clock,
                              color: AppColor.defaultColor,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              notify.notifyTime??'',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                         ),
                        ),
                      ),
             
                    ],
                  ),
                );
  }
}