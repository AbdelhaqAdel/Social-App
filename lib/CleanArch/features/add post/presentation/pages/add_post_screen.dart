import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import '../../../../../shared/Cubit/cubit/app_cubit.dart';

class AddPostScreen extends StatelessWidget {
  final postTextController =TextEditingController();

  AddPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,stata){},
        builder: (context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
               
              backgroundColor: AppColor.layoutBackgroundColor,
              title: Text("Create Post",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColor.titleText
                ),
              ),
              actions: [
                TextButton(onPressed: (){
                  cubit.AddPost(
                      postText:postTextController.text,
                  );
                 cubit.sendNewNotification();
                 // cubit.GetPosts();
                  Navigator.pop(context);
                }, child:Text('Post',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20.sp
                  )
                  ),
                ),
              ],
               leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                         icon: const Icon(Icons.arrow_back_ios,color: AppColor.whiteColor,),
                      ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if(state is ImagePostUploadLoadingState)
                    const LinearProgressIndicator(),
                  //   Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 26.sp,
                  //       backgroundImage:NetworkImage('${cubit.userModel?.image}'),
                  //     ),
                  //   SizedBox(width: 10.w,),
                  //   Column(
                  //         children: [
                  //           Text('${cubit.userModel?.name}',
                  //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //                 height: 2,
                  //                 fontSize: 20.sp,
                  //             ),
                  //           ),
                  //           SizedBox(height: 10.h,),
                  //         ],
                  //       ),
                  //   ],
                  // ),
                
                  const SizedBox(height:20,),
                   TextFormField(
                        controller: postTextController,
                        decoration:  InputDecoration(
                          counterStyle: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black
                          ),
                        hintText: 'what is in your mind .....',
                          border: InputBorder.none
                        ),
                      ), 
                  cubit.pickPostImage!=null?
                      Expanded(child:SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Card(
                            clipBehavior:Clip.antiAliasWithSaveLayer,
                            elevation: 10,
                            child: Image.memory(cubit.pickPostImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ),
                      )
                  :const SizedBox(),
                  const Spacer(),
                  Row(
                    children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height/15,
                      decoration: BoxDecoration(
                        color: AppColor.layoutBackgroundColor
                        // Colors.grey.withOpacity(0.5),
                      ),
                      child:cubit.pickPostImage==null?TextButton(
                          onPressed: (){
                            cubit.PickPostImage();
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text('Add photo',
                                  style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                   color: AppColor.whiteColor,
                                  ),
                              ),
                            ],
                          )
                      )
                          :TextButton(
                          onPressed: (){
                            cubit.uploadPostImage();
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text('Done',
                                style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                   color: AppColor.whiteColor,

                                ),
                              ),
                            ],
                          )

                      ),
                    ),
                  ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
