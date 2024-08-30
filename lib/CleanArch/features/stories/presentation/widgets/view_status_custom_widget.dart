import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class ViewStatusWidget extends StatelessWidget {
  const ViewStatusWidget({super.key,
  required this.status,
  required this.index,
  });
  final List<StatusModel> status;
  final int index;
  @override
  Widget build(BuildContext context) {
    return   Stack(
      children:[
        Container(
          // height: 700,
          // width: 400,
          child: status[index].postImage != null
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Expanded(
                    child: Card(
                      child: Image.network('${status[index].postImage}'),
                    ),
                  ),
                  
                  Text(
                    '${status[index].postText}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ])
              : Container(
                 color: Colors.red,
                  child: Center(
                    child: Text('${status[index].postText}'),
                  ),
                )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).allStatus.clear();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).allStatus[index].image}'),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '${AppCubit.get(context).allStatus[index].name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Text(
              'at ${DateTime.parse(status[index].postDate!).hour}:${DateTime.parse(status![index].postDate!).minute}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                color: Colors.black,
                  height:1,
                fontSize: 15

              ),
              ),
            ],
          ),
        ),
      ]
    );

  }
}