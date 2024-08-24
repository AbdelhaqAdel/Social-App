import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:newapp/shared/ListComponent/ListComponent.dart';

import '../../models/PostModel/PostModel.dart';
import 'AddStatusScreen.dart';
import 'AddTextStatusScreen.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
         List<statusModel>? status=cubit.allUserAddStatus;
          return StreamBuilder<QuerySnapshot>(
            stream: cubit.getStatusUpdates(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              // List<statusModel> status =AppCubit.get(context).convertListQuerySnapshotToList(snapshot.data!);
              // !.docs
              //     .map((doc) => statusModel.fromJson(doc.data()as Map<String,dynamic>))
              //     .toList();

              //print(cubit.convertListQuerySnapshotToList(snapshot.data!)?.toMap().length);
              // else if (snapshot.){
              //   print(snapshot.data);
              //   status?.add(
              //       cubit.convertListQuerySnapshotToList(querySnapshot:snapshot.data!)!);
              //  // snapshot.data?.docs.clear();
              //
              // }
             // snapshot.data = null;

              // status== cubit.allUserAddStatus;
               // FirebaseFirestore.instance.collection('users')
               //    .doc(cubit.userModel?.uId).collection('status').get().then((value) {
               //      print(value.docs);
               //      if(value.docs!=[]){
                          //snapshot.data.?docs
                         //.map((doc) => statusModel.fromJson(doc.data() as Map<String, dynamic>))
              //       }
              // });

               // status = snapshot.data.docs
               //    .map((doc) => statusModel.fromJson(doc.data() as Map<String, dynamic>))
               //    .toList();
              // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //   return Center(child: Text('No status updates available.'));
              // }
            //   cubit.AddUsersStatus();
             // var ss =cubit.convertListQuerySnapshotToList(snapshot.requireData);
             //  String aa= snapshot.data!.docs.
             //      .map((doc) =>
             //          statusModel.fromJson(doc.data() as Map<String, dynamic>))
             //      .toString();
             //  print(aa[]);
              //cubit.AddUsersStatus(statusText:aa);
             // print(aa[0].postText);
              return Scaffold(

                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text('status'),
                ),
                body: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.pickStatusImage = null;
                                NavigateTo(context, AddStatusScreen());
                              },
                              child: Row(children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      '${cubit.userModel?.image}'
                                      //'https://th.bing.com/th/id/OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8?pid=ImgDet&rs=1'
                                      //${post?.image}'
                                      ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Text(
                                    'Add to your story',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(height: 1.5),
                                  ),
                                ),
                              ]),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  cubit.anotherGetStatus(cubit.userModel!.uId!);
                                  //print(cubit.allUserAddStatus?[1].postText);
                                  NavigateTo(context, TextStatusScreen());
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300],
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Recent updates',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: ListView.separated(
                          itemBuilder: (context, index) =>
                              BuildStatusWidget(context, status!, index),
                          separatorBuilder: (context, index) => Column(
                            children: [
                              Container(
                                height: 1,
                                color: Colors.grey[300],
                                width: double.infinity,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                          itemCount: status!.length,
                        )

                            // ConditionalBuilder(
                            //   condition: state is! GetUserAddStatusLoadingState,
                            //   builder: (context) =>
                            //       ListView.separated(
                            //
                            //           itemBuilder: (context, index) =>
                            //               BuildStatusWidget(
                            //                   context, status!, index),
                            //           separatorBuilder: (context, index) =>
                            //               Column(
                            //                 children: [
                            //                   Container(
                            //                     height: 1,
                            //                     color: Colors.grey[300],
                            //                     width: double.infinity,
                            //                   ),
                            //                   SizedBox(height: 10,),
                            //                 ],
                            //               ),
                            //           itemCount: status!.length),
                            //   fallback: (context) =>
                            //       Center(child: CircularProgressIndicator()),
                            // ),
                            ),
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

//
// class StatusScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppState>(
//       listener: (context, state) {},
//       builder: (context, stat    AppCubit cubit = AppCubit.get(context);
//
//         return Scaffold(
//             Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: AppBar(
//                 backgroundColor: Colors.transparent,
//                 title: Text('status'),
//               ),
//               body: Container(
//                 color: Colors.transparent,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               cubit.pickStatusImage = null;
//                               NavigateTo(context, AddStatusScreen());
//                             },
//                             child: Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: NetworkImage(
//                                         '${cubit.userModel?.image}'
//                                       //'https://th.bing.com/th/id/OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8?pid=ImgDet&rs=1'
//                                       //${post?.image}'
//                                     ),
//                                   ),
//
//
//                                   SizedBox(width: 10,),
//                                   Container(
//                                     child: Text('Add to your story',
//                                       style: Theme
//                                           .of(context)
//                                           .textTheme
//                                           .bodyText1
//                                           ?.copyWith(
//                                           height: 1.5
//                                       ),
//                                     ),
//                                   ),
//                                 ]
//                             ),
//                           ),
//                           Spacer(),
//                           IconButton(
//                               onPressed: () {
//                                 cubit.anotherGetStatus(cubit.userModel!.uId!);
//                                 //print(cubit.allUserAddStatus?[1].postText);
//                                 NavigateTo(context, TextStatusScreen());
//                               },
//                               icon: Icon(Icons.edit)),
//                         ],
//                       ),
//                       SizedBox(height: 15,),
//                       Container(
//                         height: 1,
//                         color: Colors.grey[300],
//                         width: double.infinity,
//                       ),
//                       SizedBox(height: 15,),
//                       Text('Recent updates',
//                         style: Theme
//                             .of(context)
//                             .textTheme
//                             .bodyText1,
//                       ),
//                       SizedBox(height: 10,),
//                       Expanded(
//
//                         child: ConditionalBuilder(
//                           condition: state is! GetUserAddStatusLoadingState,
//                           builder: (context) =>
//                               ListView.separated(
//
//                                   itemBuilder: (context, index) =>
//                                       BuildStatusWidget(
//                                           context, status!, index),
//                                   separatorBuilder: (context, index) =>
//                                       Column(
//                                         children: [
//                                           Container(
//                                             height: 1,
//                                             color: Colors.grey[300],
//                                             width: double.infinity,
//                                           ),
//                                           SizedBox(height: 10,),
//                                         ],
//                                       ),
//                                   itemCount: status!.length),
//                           fallback: (context) =>
//                               Center(child: CircularProgressIndicator()),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           // ... Your other scaffold properties ...
//
//           body: Container(
//             // ... Other container properties ...
//
//             child: StreamBuilder<QuerySnapshot>(
//               stream: cubit.getStatusUpdates(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
//                   return Center(child: Text('No status updates available.'));
//                 }
//                 List<statusModel> status = snapshot.data.docs
//                     .map((doc) => statusModel.fromJson(doc.data()))
//                     .toList();
//
//                 return ListView.separated(
//                   itemBuilder: (context, index) => BuildStatusWidget(context, status, index),
//                   separatorBuilder: (context, index) => Column(
//                     children: [
//                       Container(
//                         height: 1,
//                         color: Colors.grey[300],
//                         width: double.infinity,
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                   itemCount: status.length,
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
