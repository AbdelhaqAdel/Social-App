import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/all_posts_component.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

// ignore: must_be_immutable
class PostsScreen extends StatelessWidget {
  CollectionReference allPosts = FirebaseFirestore.instance.collection('posts');
  var scaffoldKey=GlobalKey<ScaffoldState>();
  PostsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder:(context) {
        AppCubit.get(context).GetPostsData();
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            List<PostModel>posts = cubit.posts;
            // return StreamBuilder<QuerySnapshot>(
            //     stream: allPosts.orderBy('postDate', descending: false)
            //         .snapshots(),
            //     builder: (BuildContext context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('Error: ${snapshot.error}');
            //       }
            //
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //             child: CircularProgressIndicator()); // or any other loading indicator
            //       }
            //
            //       if (!snapshot.hasData) {
            //         return Text('No data available'); // Handle empty feed
            //       }
            //
            //       // Assuming you have a function to convert QuerySnapshot to a list of PostModel
            //       posts = cubit.convertQuerySnapshotToList(snapshot.data!);
                  //cubit.GetPosts();
                  //   StreamBuilder<QuerySnapshot>(
                  // stream: allPosts.orderBy('postDate',descending: true).snapshots(),
                  //  builder:(BuildContext context, snapshot) {
                  //   // if(snapshot.data!.size > posts.length){
                  //   //   print(snapshot.data!.docs);
                  //   //   //cubit.GetPosts();
                  //   //  // snapshot.data?.docs.forEach((element) {    //element is map<String dynamic> contain all data in post model
                  //   // //  print(element.data());
                  //   //   //cubit.AddPost();
                  //   //   //posts.add(snapshot.data!.docs[snapshot.data!.docs.length-1]);    //to add all data in element to posts list
                  //   //  // });
                  //   //   // for(int i=0;i<snapshot.data!.docs.length;i++){
                  //   //   //   posts.add(PostModel.fromJson()
                  //   //   // }
                  //   // }
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
                                ConditionalBuilder(
                                  condition:
                                  posts.isNotEmpty &&
                                      cubit.likesNum.isNotEmpty
                                      &&cubit.commentNum.isNotEmpty
                                     && cubit.state is! GetPostLoadingState,
                                  builder: (context) {
                                    return ListView.separated(
                                        reverse: true,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var commentController = TextEditingController();
                                          return BuildPostsWidget(
                                            commentController: commentController,
                                            scaffoldKey: scaffoldKey,
                                            post: posts[index],
                                            index: index,);
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 3.h,),
                                        itemCount: posts.length
                                    );
                                  },
                                  fallback: (context) =>
                                      const Center (child: CircularProgressIndicator()),
                                ),
                            SizedBox(height: MediaQuery.of(context).size.height/13),
                          ],
                        ),
                      ),
                    ),
                  );
       
          },
        );
      });
  }
}
