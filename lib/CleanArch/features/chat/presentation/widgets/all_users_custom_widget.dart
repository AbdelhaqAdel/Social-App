import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';


class AllUsersWidget extends StatelessWidget {
  const AllUsersWidget({
    required this.user,
    super.key});
    final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
         height:80,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.titleText.withOpacity(.5),width: 2),
              borderRadius: BorderRadius.circular(30,)
              ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26.sp,
                backgroundImage: NetworkImage('${user.image}'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${user.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey[400], height: 1.5),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 17,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      height: 30,
                      width: 240,
                      child: Text(
                        'last message',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            height: 1.h,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.list))
            ],
          ),
      ),
    );
    

  }
}