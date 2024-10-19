import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';

class ViewStatusWidget extends StatelessWidget {
  const ViewStatusWidget({super.key,
  required this.status,
  required this.index,
  });
  final List<StatusModel> status;
  final int index;
  @override
  Widget build(BuildContext context) {

    return   
        Container(
           color: Color(status[index].statusColor!),
            child: Center(
              child: Text('${status[index].statusText}',
              style: const TextStyle(
                fontSize: 25,
                color: AppColor.whiteColor
              ),
              ),
            ),
          );

  }
}