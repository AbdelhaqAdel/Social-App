import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';

class StatusCustomWidget extends StatelessWidget {
  const StatusCustomWidget({
    required this.status,
    required this.index,
    super.key});
   final List<Map<String,dynamic>> status;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(children: [
        Stack(alignment: Alignment.center, children: [
              Container(
                height: 63,
                width: 63,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 4)),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${status[index]['image']}'
                    ),
              ),
            ]),
          
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${status[index]['name']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(height: 2,fontSize: 18.sp),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
              'at ${DateTime.parse(status[index]['date']).hour}:${DateTime.parse(status[index]['date']).minute}',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(height: 0.5,color: Colors.grey[400]),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ]),
        const Spacer(),
        CircleAvatar(backgroundColor: AppColor.defaultColor,
        radius: 12.sp,
        child:Text(status[index]['statusNumber'].toString()),
        ),
      ],
    );

  }
}
