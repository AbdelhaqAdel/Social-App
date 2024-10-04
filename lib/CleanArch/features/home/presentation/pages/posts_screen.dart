import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_comment_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_like_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/create_post_usecase.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/posts_builder.dart';

class PostsScreen extends StatelessWidget {

  final scaffoldKey=GlobalKey<ScaffoldState>();
  PostsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder:(context) {
        return BlocProvider(
          create: (context)=>PostCubit(
            postRepository:getIt.get<PostRepository>(),postLikeRepo:getIt.get<PostLikeRepository>(),
          postCommentRepo: getIt.get<PostCommentRepository>(),
          createPostUseCase: getIt.get<CreatePostUseCase>()
          )..fetchAllPosts(),
          child: BlocConsumer<PostCubit, PostState>(
            listener: (context, state) {},
            builder: (context, state) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      key: scaffoldKey,
                      body: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10, top: 14),
                                child: Row(
                                  children: [
                                     Text('For You',
                                      style:Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppColor.titleText,
                                        fontSize: 22.sp
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(onPressed: () {},
                                      icon:  const Icon(Icons.search,color: AppColor.titleText,),),
                                    IconButton(onPressed: () {},
                                      icon: const Icon(Icons.notifications,color: AppColor.titleText,),),
                                  ],
                                ),
                              ),

                              PostsBuilder(scaffoldKey: scaffoldKey,),
                              SizedBox(height: MediaQuery.of(context).size.height/13),
                            ],
                          ),
                        ),
                      ),
                    );
               
            // });
            
            }
          ),
        );
      });
  }
}
