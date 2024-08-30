import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/CleanArch/features/add%20post/presentation/widgets/image_card.dart';
import 'package:newapp/CleanArch/features/add%20post/presentation/widgets/select_image.dart';
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
                   const PostImageCard()   
                   :const SizedBox(),
                   const Spacer(),
                   const SelectImageButton()    
                   ],
              ),
            ),
          );
        },
    );
  }
}
