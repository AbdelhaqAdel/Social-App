import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_comment_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_like_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/create_post_usecase.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/add%20post/image_card.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/add%20post/select_image.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
   TextEditingController postTextController =TextEditingController();

    return BlocProvider(
      create: (context )=>PostCubit(postRepository:getIt.get<PostRepository>(),postLikeRepo:getIt.get<PostLikeRepository>(),
          postCommentRepo: getIt.get<PostCommentRepository>(),
          createPostUseCase: getIt.get<CreatePostUseCase>()
       ),
      child: BlocConsumer<PostCubit,PostState>(
          listener:(context,state){},
          builder: (context,state){
            PostCubit cubit =PostCubit.get(context);
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
                     cubit.createPost(
                        postText:postTextController.text,
                    ).then((value) => GoRouter.of(navigatorKey.currentState!.context).pop());
                  }, child:Text('Post',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20.sp)
                    ),
                  ),
                ],
                 leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);},
                     icon: const Icon(Icons.arrow_back_ios,color: AppColor.whiteColor,),
                  ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if(cubit.state is UploadPostImageLoadingState||cubit.state is UploadPostImageLoadingState)
                      const LinearProgressIndicator(),
                     const SizedBox(height:20,),
                     TextFormField(
                          controller: postTextController,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                              fontSize: 30.sp,
                              color:Colors.black,
                            ),  
                          decoration:  InputDecoration(
                            
                            hintStyle: TextStyle(
                              fontSize: 25.sp,
                              color:Colors.grey,
                            ),
                          hintText: 'what is in your mind .....',
                            border: InputBorder.none
                          ),
                        ), 
                     cubit.imageString!=''?
                     const PostImageCard()   
                     :const SizedBox(),
                     const Spacer(),
                     const SelectImageButton()    
                     ],
                ),
              ),
            );
          },
      ),
    );
  }
}
