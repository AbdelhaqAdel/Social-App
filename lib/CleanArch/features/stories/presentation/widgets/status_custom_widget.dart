import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/stories/presentation/pages/show_status.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';
import 'package:newapp/CleanArch/core/utils/widgets/static_component.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class StatusCustomWidget extends StatelessWidget {
  const StatusCustomWidget({
    required this.status,
    required this.index,
    super.key});
   final List<StatusModel> status;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            GestureDetector(
              onTap: () {
                AppCubit.get(context).anotherGetStatus(
                    AppCubit.get(context).allUserAddStatus![index].uId);
                //  print(AppCubit.get(context).allStatus?.length);
                NavigateTo(context, ShowStatus());
                // print(AppCubit.get(context).allUserAddStatus![index].uId);
              },
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  height: 63,
                  width: 63,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      //shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 4)),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${status[index].image}'
                      //'https://th.bing.com/th/id/OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8?pid=ImgDet&rs=1'
                      //${post?.image}'
                      ),
                ),
              ]),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${status[index].name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.5),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text(
                  // 'at ${DateTime.parse(status.postDate!).hour}:${DateTime.parse(status.postDate!).minute}',
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .caption
                  //     ?.copyWith(height: 0.5),
                  // ),
                ],
              ),
            ),
          ]),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
        ],
      ),
    );

  }
}
