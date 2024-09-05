import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';

class AuthorData extends StatelessWidget {
  const AuthorData({super.key,
  required this.post,
  });
   final PostModel post;

  @override
  Widget build(BuildContext context) {
    var postDate=DateTime.parse(post.postDate!);

    return 
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage('${post.image}'),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${post.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Colors.grey[400], height: 1.h),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                             Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 17.sp,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          '${postDate.day}-${postDate.month}'
                          '-${postDate.year} at ''${postDate.hour}:${postDate.minute}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                height: 0.5,
                                color: Colors.grey[400],
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.list))
                ],
              );
  }
}