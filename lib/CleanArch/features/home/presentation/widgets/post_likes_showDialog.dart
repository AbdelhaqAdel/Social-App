import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/widgets/glass_box_custom_widget.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/posts_likes_component.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class PostLikesDialog extends StatelessWidget {
  const PostLikesDialog({
    required this.height,
    required this.width,
    super.key
    });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
      AppCubit cubit=AppCubit.get(context);
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
                         height: height,
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
                                           Expanded(
                                                 child: ConditionalBuilder(
                                                      condition:cubit.likedName.isNotEmpty
                                                          || AppCubit.get(context).state is GetPostsLikesSuccessState ,
                                                      builder: (context) => ListView.builder(
                                                          itemBuilder: (context, index) =>
                                                              PostsLikesWidget(index: index,),
                                                      
                                                          itemCount: AppCubit.get(context)
                                                              .likedName
                                                              .length),
                                                      fallback: (context) =>
                                                          const Center(
                                                              child: CircularProgressIndicator()),
                                        ),
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


