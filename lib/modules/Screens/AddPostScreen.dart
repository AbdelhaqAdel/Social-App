import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../LayoutScreens/ChatLayoutScreen.dart';
import '../../shared/Cubit/cubit/app_cubit.dart';

class AddPostScreen extends StatelessWidget {
  var postTextController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,stata){},
        builder: (context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text("Create Post"),
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
                    color: Colors.black,
                    fontSize: 20
                  )
                  ),
                ),
              ],
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if(state is ImagePostUploadLoadingState)
                      LinearProgressIndicator(),
                      Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage:NetworkImage('https://th.bing.com/th/id/OIP.Az3XDTKRMTQ2K1cK5hzVzQHaHk?pid=ImgDet&w=202&h=206&c=7&dpr=1.1'),
                        ),
                      SizedBox(width: 15,),
                      Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Abdelhaq Adel',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.5
                                ),
                              ),
                              SizedBox(height: 10,),

                            ],
                          ),

                      ],
                    ),
                    SizedBox(height: 20,),
                  Container(
                    height: 40,
                        child: TextFormField(
                          controller: postTextController,
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.black
                            ),
                          hintText: 'what is in your mind .....',
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    cubit.pickPostImage!=null?
                        Expanded(child:Container(
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
                    :SizedBox(),
                    Spacer(),
                    Row(
                      children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child:cubit.pickPostImage==null?TextButton(
                            onPressed: (){
                              cubit.PickPostImage();
                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image,color: Colors.black,),
                                SizedBox(width: 5,),
                                Text('Add photo',
                                    style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.black,
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
                                Icon(Icons.image,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text('Done',
                                  style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
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
            ),
          );
        },
    );
  }
}
