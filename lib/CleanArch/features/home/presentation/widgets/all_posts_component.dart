
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';
import 'package:newapp/models/PostModel/PostModel.dart';
import 'package:newapp/modules/Screens/ShowUsersLikedPosts/ShowUsersLikedPosts.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
class BuildPostsWidget extends StatelessWidget {
  const BuildPostsWidget({
    required this.commentController,
    required this.scaffoldKey,
    required this.post,
    required this.index,
    super.key
    });
   final TextEditingController commentController;
   final GlobalKey<ScaffoldState> scaffoldKey;
   final PostModel post;
   final int index;


  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color:AppColor.postCardColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                      color: Colors.grey[400], height: 1.5),
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
                          '${DateTime.parse(post.postDate!).year}-${DateTime.parse(post.postDate!).month}'
                          '-${DateTime.parse(post.postDate!).day} at '
                          '${DateTime.parse(post.postDate!).hour}:${DateTime.parse(post.postDate!).minute}',
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
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                '${post.postText}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 17.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[400],
                    ),
              ),
            
              // SizedBox(
              //   width: double.infinity,
              //   child: Wrap(
              //     children: [
              //       SizedBox(
              //           height: 25.h,
              //           child: MaterialButton(
              //             minWidth: 0.5,
              //             onPressed: () {},
              //             child: Text(
              //               'Alfyyy',
              //               style: TextStyle(
              //                 color: HexColor('#13003b'),
              //               ),
              //             ),
              //           )),
              //       Container(
              //         height: 25,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           child: Text(
              //             'flutter developer',
              //             style: TextStyle(
              //               color: HexColor('#13003b'),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10.h,
              ),
              post.postImage != null
                  ? SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        child: Image.network(
                          '${post.postImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 0.4,
                color: HexColor('#13003b'),
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AppCubit.get(context)
                          .getLikedUsers(AppCubit.get(context).likes[index]);
                      NavigateTo(context, ShowUserLikedPosts());
                    },
                  
                    // {
                    //   print(AppCubit.get(context).isBottomSheetShown);
                    //
                    //   if (AppCubit.get(context).isBottomSheetShown) {
                    //     Navigator.pop(context);
                    //     AppCubit.get(context).isBottomSheetShown = false;
                    //     print(AppCubit.get(context).isBottomSheetShown);
                    //   } else
                    //     // if(AppCubit.get(context).likedName
                    //     //   .length!=[])
                    //   {
                    //     AppCubit.get(context).getLikedUsers(
                    //         AppCubit.get(context).likes[index]);
                    //     //}
                    //
                    //     ScaffoldKey?.currentState
                    //         ?.showBottomSheet((context) => Container(
                    //               height: 200,
                    //               width: double.infinity,
                    //               color: Colors.red,
                    //               child: ConditionalBuilder(
                    //                 condition:
                    //               //    AppCubit.get(context).state is !GetPostsLikesLoadingState,
                    //               AppCubit.get(context).likedName.isNotEmpty,
                    //                 builder: (context) => ListView.separated(
                    //                     itemBuilder: (context, index) =>
                    //                         UserLikedWidget(index, context),
                    //                     separatorBuilder: (context, index) =>
                    //                         SizedBox(
                    //                           height: 15,
                    //                         ),
                    //                     itemCount: AppCubit.get(context)
                    //                         .likedName
                    //                         .length),
                    //                 fallback: (context) =>
                    //                     Center(child: CircularProgressIndicator(color: Colors.white,),),
                    //               ),
                    //             ))
                    //         .closed
                    //         .then((value) {
                    //       AppCubit.get(context).isBottomSheetShown = false;
                    //       // AppCubit.get(context).changeBottomSheetState;
                    //     });
                    //     AppCubit.get(context).isBottomSheetShown = true;
                    //     //                     AppCubit.get(context).changeBottomSheetState;
                    //   }
                    //   //isBottomSheetShown=true;
                    //
                    //   //  AppCubit.get(context).getLikesByName(AppCubit.get(context).likes[index]);
                    // },
                  
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 18,
                        ),
                         SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "${AppCubit.get(context).likesNum[index]}",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                              Icons.comment,
                              color: Colors.grey[400],
                              size: 15,
                            ),
                                 SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "${AppCubit.get(context).commentNum[index]}",
                         style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel?.image}'),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Write a comment',
                          hintStyle:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                        ),
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            AppCubit.get(context).addComment(
                                AppCubit.get(context).likes[index!], value);
                            commentController.clear();
                          }
                        },
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .addLike(AppCubit.get(context).likes[index]);
                          AppCubit.get(context).changeLikeButtonColor(
                              AppCubit.get(context).likes[index]);
                        },
                        icon: const Icon(Icons.favorite_border,
                            size: 25,
                            color: // AppCubit.get(context).userLiked![AppCubit.get(context).likes[index]]!
                                Colors.red
                       
                            )),
                  ],
                ),
              SizedBox(
                height: 7.h,
              ),
            ],
          ),
        ),
      ),
    );


  }
}


