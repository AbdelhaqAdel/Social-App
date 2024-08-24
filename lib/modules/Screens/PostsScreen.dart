import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/all_posts_component.dart';
import 'package:newapp/models/PostModel/PostModel.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import '../../shared/ListComponent/ListComponent.dart';

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
                                   Text('Posts',
                                    style:Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColor.titleText,
                                      fontSize: 22.sp
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(onPressed: () {},
                                    icon: const Icon(Icons.search, size: 25,),),
                                  IconButton(onPressed: () {
                                    // showDialog<String>(
                                    //   context: context,
                                    //   barrierColor: Colors.black.withOpacity(.02),
                                    //   useSafeArea: true,
                                    //   builder: (BuildContext context) =>
                                    //       AlertDialog(
                                    //         insetPadding: const EdgeInsets.all(0.0),
                                    //         scrollable: false,
                                    //         shadowColor: Colors.transparent,
                                    //
                                    //         // title: const Text('AlertDialog Title'),
                                    //         content: Center(
                                    //           child: Container(
                                    //             width:
                                    //             MediaQuery.of(context).size.width,
                                    //             child: GestureDetector(
                                    //               onTap: () {
                                    //                 Navigator.pop(context);
                                    //               },
                                    //               child: GlassBox(
                                    //                   widget: Stack(
                                    //                     children: [
                                    //                       Column(
                                    //                         children: [
                                    //                           const SizedBox(
                                    //                             height: 60,
                                    //                           ),
                                    //                           Text(
                                    //                             'Notifications',
                                    //                             style: TextStyle(
                                    //                                 fontSize: 25,
                                    //                                 fontWeight:
                                    //                                 FontWeight.w900,
                                    //                                 color: Colors.black
                                    //                                     .withOpacity(
                                    //                                     .7)),
                                    //                           ),
                                    //                           ConditionalBuilder(
                                    //                             condition:cubit.stuHistoryModel.isNotEmpty||cubit.insHistoryModel.isNotEmpty,
                                    //                             builder:(context)=> Expanded(
                                    //                               child: Padding(
                                    //                                 padding:
                                    //                                 const EdgeInsets
                                    //                                     .only(
                                    //                                     top: 40,
                                    //                                     left: 15,
                                    //                                     bottom: 0,
                                    //                                     right: 15),
                                    //                                 child:  ListView
                                    //                                     .separated(
                                    //                                   physics:
                                    //                                   const BouncingScrollPhysics(),
                                    //                                   itemBuilder: (context, index) {
                                    //                                     return rol=='Student'? historyCard(
                                    //                                         icon: recent[index],
                                    //                                         history: cubit.stuHistoryModel[index],
                                    //                                         // :cubit.insHistoryModel[index],
                                    //                                         context: context
                                    //                                     ): insHistoryCard(
                                    //                                         icon: recent[index],
                                    //                                         history: cubit.insHistoryModel[index],
                                    //                                         // :cubit.insHistoryModel[index],
                                    //                                         context: context
                                    //                                     );
                                    //                                   },
                                    //                                   separatorBuilder:
                                    //                                       (context,
                                    //                                       index) =>
                                    //                                       Container(
                                    //                                         height: 15,
                                    //                                         color: Colors
                                    //                                             .transparent,
                                    //                                       ),
                                    //                                   itemCount: rol=='Student'? cubit.stuHistoryModel.length
                                    //                                       :cubit.insHistoryModel.length,
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                             fallback:(context)=>SizedBox(),
                                    //                           ),
                                    //                         ],
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   color: Colors.transparent,
                                    //                   borderRadius: 0,
                                    //                   x: 50,
                                    //                   y: 50),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         elevation: 0,
                                    //         clipBehavior: Clip.none,
                                    //         surfaceTintColor: Colors.transparent,
                                    //         backgroundColor: Colors.transparent,
                                    //         contentPadding: EdgeInsets.zero,
                                    //       ),
                                    // );
                                  },
                                    icon: const Icon(Icons.notifications),),
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
                                            SizedBox(height: 8.h,),
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
