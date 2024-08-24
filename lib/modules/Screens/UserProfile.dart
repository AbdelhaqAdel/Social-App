import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/modules/Screens/EditProfileScreen/EditProfileScreen.dart';
import 'package:newapp/modules/UserScreens/UserLogin/LoginScreen.dart';
import 'package:newapp/shared/Component/StaticComponent.dart';

import '../../models/UserModel/UsersModel.dart';
import '../../shared/Constants/KeyConstants.dart';
import '../../shared/Cubit/cubit/app_cubit.dart';
import '../../shared/network/local/CacheHelper.dart';
// import 'package:flutter/src/widgets/framework
// import 'package:flutter_bloc/flutter_bloc.da

class USerProfile extends StatelessWidget {
  const USerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
          if(state is shopGetUserSuccessState){
            uid=CacheHelper.getData('uid');
            print('uid from get data : ${uid}');
          }
        },
        builder:(context,state){
          AppCubit cubit =AppCubit.get(context);
          UserRegisterModel ?userModel=cubit.userModel;
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Text('${userModel?.name}',
                  ),
                  IconButton(onPressed: (){},
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
              actions:[

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                      },
                        icon: Icon(Icons.add),),
                      SizedBox(
                        width: 0,
                      ),
                      Icon(Icons.menu),
                    ],
                  ),
                ),

              ],

            ),
            body:
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(

                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(

                 crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          height: 230,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children:[
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  width: double.infinity,
                                  height: 180,
                                  child: Card(
                                    //margin: EdgeInsets.all(8),
                                    //clipBehavior:Clip.antiAliasWithSaveLayer,
                                    elevation: 10,
                                    child: Image.network('${userModel?.cover}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(

                                backgroundColor:HexColor('#13003b'),
                                radius: 48,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${userModel?.image}'),
                                  radius: 45,
                            ),
                              ),
                              ]
                          ),
                        ) ,

                        // ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${userModel?.nickname}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[400],
                                fontSize: 15
                            )
                          ),
                          Text('${userModel?.bio}',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[400],
                                  //fontSize: 15
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text('2',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text('Posts',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[400],
                                  ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('632',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[400],
                                  ),
                              ),
                              Text('Followers',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    //fontSize: 15,
                                    color: Colors.grey[400],
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('622',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    //fontSize: 15,
                                    color: Colors.grey[400],
                                  )
                              ),
                              Text('Following',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    //fontSize: 15,
                                    color: Colors.grey[400],

                                  )
                              )
                            ],
                          ),
                        ),
                      ],),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                cubit.Image = null;
                                cubit.coverImage=null;
                                NavigateTo(context, EditProfileScreen());
                              },
                              child: Container(
                                  width: 180,
                                  height: 35,
                                  padding: EdgeInsets.all(7),
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10,),
                                    color: Colors.grey[500],
                                  ),
                                  child:
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      Text('Edit profile',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontSize: 17,

                                        ),
                                      ),
                                      SizedBox(width: 5,),

                                    ],
                                  )
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),

                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                CacheHelper.removedata(key: 'uid');
                                NavigateAndFinish(context, LoginSreen());
                              },
                              child:  Container(
                                    height: 35,
                                    padding: EdgeInsets.all(7),
                                    decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(10,),
                                      color: Colors.grey[500],
                                    ),
                                    child:
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text('Log out',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontSize: 17,

                                          ),
                                        ),

                                      ],
                                    )
                                ),
                              
                            ),
                          ),
                          // Container(
                          //   width: 35,
                          //   height: 35,
                          //   //  padding: EdgeInsets.all(15),
                          //   decoration:BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10,),
                          //     color: Colors.grey[800],
                          //   ),
                          //   child:
                          //   IconButton(onPressed: (){},
                          //     icon: Icon(Icons.person_add_alt_1_outlined),
                          //     color: Colors.white,
                          //   ),
                          //
                          // ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: HexColor('#ea1a78'),

                                  child: CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.white,

                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:HexColor('#13003b'),
                                      child: Icon(Icons.add,
                                        color: Colors.white,
                                      ),

                                    ),
                                  ),
                                ),
                                Text('new',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),

                          ),

                        ],
                      ),
                      Container(height: 0.5,color: Colors.grey[400],),
                      Row(
                        children: [
                          Expanded(
                            child:
                            IconButton(onPressed: (){
                              FirebaseMessaging.instance.subscribeToTopic('message');
                            },
                              iconSize: 40,
                              icon: Icon(Icons.square_sharp),
                              color:HexColor('#ea1a78'),
                            ),
                          ),
                          Container(
                            height: 26,
                            width: 0.5,
                            color: Colors.grey[300],
                          ),
                          Expanded(child:
                          IconButton(onPressed: (){
                            FirebaseMessaging.instance.unsubscribeFromTopic('message');
                          },

                            iconSize: 35,
                            icon: Icon(Icons.person_outline_rounded),

                            color:HexColor('#ea1a78'),
                          ),
                          ),

                        ],
                      ),
                    ]
                  ),

                ),
              ),
            ),
          );
    },);
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';rt';.dart';
//
// class insta extends StatefulWidget {
//   const insta({Key? key}) : super(key: key);
//
//   @override
//   State<insta> createState() => _instaState();
// }
//
// class _instaState extends State<insta> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Row(
//           children: [
//             Text('_3b7ak',
//             ),
//             IconButton(onPressed: (){},
//               icon: Icon(Icons.keyboard_arrow_down),
//             ),
//           ],
//         ),
//         actions:[
//
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 15,
//             ),
//             child: Row(
//               children: [
//                 IconButton(onPressed: (){},
//                   icon: Icon(Icons.add),),
//                 SizedBox(
//                   width: 0,
//                 ),
//                 Icon(Icons.menu),
//               ],
//             ),
//           ),
//
//         ],
//
//       ),
//       body:
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.black,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('assets/images/meph.jpg'),
//                   radius: 45,
//                   //Image(
//                   // image: AssetImage('assets/images/meph.jpg'),
//                   //  width: 90,
//                   // height: 90,
//                 ) ,
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text('2',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text('Posts',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text('632',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text('Followrs',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text('622',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text('Following',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 // ),
//               ],),
//               SizedBox(
//                 height: 10,
//               ),
//               Text('Alfy',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Text('CS',
//                 style: TextStyle(
//                   //fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Text('"اللهم عمرا فى رضاك وموتا على حسن خاتمه"',
//                 style: TextStyle(
//                   //fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               /*Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children:[
//                 Text('Alfy',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 ),
//                 Text('CS',
//                 style: TextStyle(
//                   //fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 ),
//                 Text('"اللهم عمرا فى رضاك وموتا على حسن خاتمه"',
//                 style: TextStyle(
//                   //fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 ),
//               ],
//             ),*/
//               Row(
//                 children: [
//                   Container(
//                       width: 320,
//                       height: 35,
//                       padding: EdgeInsets.all(7),
//                       decoration:BoxDecoration(
//                         borderRadius: BorderRadius.circular(10,),
//                         color: Colors.grey[800],
//                       ),
//                       child:
//                       Row(
//                         mainAxisAlignment:MainAxisAlignment.center,
//                         children: [
//                           Text('Edit Profile',
//                             style: TextStyle(
//                               color:Colors.white,
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//
//                   SizedBox(width: 5,),
//                   Container(
//                     width: 35,
//                     height: 35,
//                     //  padding: EdgeInsets.all(15),
//                     decoration:BoxDecoration(
//                       borderRadius: BorderRadius.circular(10,),
//                       color: Colors.grey[800],
//                     ),
//                     child:
//                     IconButton(onPressed: (){},
//                       icon: Icon(Icons.person_add_alt_1_outlined),
//                       color: Colors.white,
//                     ),
//
//                   ),
//                 ],
//               ),
//               //SizedBox(height: 20,),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius:30,
//                           backgroundImage: AssetImage('assets/images/1.jpg'),
//                         ),
//                         Icon(Icons.heart_broken,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.grey[300],
//                           child: Icon(Icons.add,
//                             color: Colors.white,
//                           ),
//
//                         ),
//                         Text('new',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                   ),
//
//                 ],
//               ),
//               //  SizedBox(height: 20,),
//               Row(
//                 children: [
//                   Expanded(
//                     child:
//                     IconButton(onPressed: (){},
//                       iconSize: 40,
//                       icon: Icon(Icons.square_sharp),
//                       color:Colors.white,
//                     ),
//                   ),
//                   Expanded(child:
//                   IconButton(onPressed: (){},
//                     iconSize: 35,
//                     icon: Icon(Icons.person_outline_rounded),
//
//                     color:Colors.white,
//                   ),
//                   ),
//
//                 ],
//               ),
//               //   SizedBox(height:30 ,),
//               Container(
//                 width: 200,
//                 height: 0.5,
//                 color: Colors.white,
//               ),
//               Row(
//                 children:[
//                   Image(image: AssetImage('assets/images/2.jpg'),
//                     height: 230,
//                     width: 150,
//                   ),
//                   SizedBox(width:5),
//                   Image(image: AssetImage('assets/images/3.jpg'),
//                     height: 230,
//                     width: 150,
//                   )
//                 ],
//               ),
//               SizedBox(height: 89.5,),
//               Container(
//                 width: double.infinity,
//                 height: 0.5,
//                 color: Colors.white,
//               ),
//               Row(
//                 children: [
//
//                   IconButton(onPressed: (){},
//                     icon:Icon(Icons.home_outlined),
//                     color: Colors.white,
//                     iconSize: 30,
//                   ),
//                   SizedBox(width: 30,),
//
//                   IconButton(onPressed: (){},
//                     icon:Icon(Icons.search),
//                     color: Colors.white,
//                     iconSize: 30,
//                   ),
//                   SizedBox(width: 30,),
//
//                   IconButton(onPressed: (){},
//                     icon:Icon(Icons.video_call_outlined,),
//                     color: Colors.white,
//                     iconSize: 30,
//                   ),
//                   SizedBox(width: 30,),
//
//                   IconButton(onPressed: (){},
//                     icon:Icon(Icons.shop_two),
//                     color: Colors.white,
//                     iconSize: 30,
//                   ),
//                   SizedBox(width: 30,),
//
//                   CircleAvatar(
//                     radius: 15,
//                     backgroundImage:AssetImage('assets/images/meph.jpg'),
//                   ),
//
//                 ],
//               ),
//             ],
//           ),
//
//         ),
//       ),
//     );
//   }
//}