import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              child: Text('${status[index].statusText}'),
            ),
          );
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(top: 45.0),
        //         child: Row(
        //           children: [
        //             IconButton(
        //               onPressed: () {
        //                  status.clear();
        //                 Navigator.pop(context);
        //               },
        //               icon: const Icon(Icons.arrow_back_ios),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(4.0),
        //               child: CircleAvatar(
        //                 radius: 27,
        //                 backgroundImage: NetworkImage(
        //                     '${status[index].userImage}'),
        //               ),
        //             ),
        //             SizedBox(
        //               width: 8.w,
        //             ),
        //             Text(
        //               '${ status[index].name}',
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .bodyLarge
        //                   ?.copyWith(fontSize: 20),
        //             ),
        //             const Spacer(),
        //                     Text(
        //       'at ${DateTime.parse(status[index].statusDate!).hour}:${DateTime.parse(status[index].statusDate!).minute}',
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodySmall
        //           ?.copyWith(
        //         color: Colors.grey[300],
        //           height:1,
        //         fontSize: 15

        //       ),
        //       ),
      
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
    

  }
}