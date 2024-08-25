import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/posts_likes_component.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
class ShowUserLikedPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){},
      builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Post likes'),
            ),
            body: Container(
              color: Colors.red,
            child: ConditionalBuilder(
                            condition: AppCubit.get(context).likedName
                                .length!=[]&& AppCubit.get(context).state is GetPostsLikesSuccessState ,
                            builder: (context) => ListView.separated(
                                itemBuilder: (context, index) =>
                                    PostsLikesWidget(index: index,),
                                separatorBuilder: (context, index) =>
                                    SizedBox(
                                      height: 15,
                                    ),
                                itemCount: AppCubit.get(context)
                                    .likedName
                                    .length),
                            fallback: (context) =>
                                Center(
                                    child: CircularProgressIndicator()),
                          ),

            ),
          );
      },

    );
  }
}
