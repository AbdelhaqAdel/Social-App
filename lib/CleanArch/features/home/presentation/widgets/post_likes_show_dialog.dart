import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/widgets/glass_box_custom_widget.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post%20reach/liked_users_builder.dart';

class PostLikesDialog extends StatelessWidget {
  const PostLikesDialog({
    required this.width,
    super.key,
  required this.cubitContext,
});
  final BuildContext cubitContext;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: AlertDialog(
         insetPadding: const EdgeInsets.all(8.0),
         scrollable: true,
         shadowColor: Colors.transparent,
         content: Center(
           child: SizedBox(

             width: MediaQuery.of(context).size.width,
             height:  MediaQuery.of(context).size.height/1.5,
             child:
                 GestureDetector(
                   onTap: (){},
                   child:glassBoxWithBorderGradiant(
                             widget: Column(
                               children: [
                                   Container(
                                    height: 35.h,
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: const Text('Post Likes',
                                    ),
                                  ),
                                  Container(
                                    height:2,
                                    color: Colors.white,
                                    ),
                                const Expanded(
                                     child:LikedUsersBuilder(),
                                   ),
                                           
                               ],
                             ),
                             color: Colors.white
                                 .withOpacity(.5),
                             borderRadius: 20,
                             x: 12,
                             y: 10,
                             borderWidth: 2,
                             borderColor: Colors.white,
                           ),
                                                                                                                                                            
            ),
               
            ) ),
         elevation: 0,
         clipBehavior: Clip.none,
         surfaceTintColor: Colors.transparent,
         backgroundColor: Colors.transparent,
         contentPadding: EdgeInsets.zero,
       ),
    );
            
  }
}


