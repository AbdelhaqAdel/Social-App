import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class AddStatusScreen extends StatelessWidget {
  var statusTextController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){},
        builder:(context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Create your story"),
              actions: [
                TextButton(onPressed: (){
                  cubit.AddUsersStatus(
                    statusText:statusTextController.text,
                  );
                  Navigator.pop(context);
                }, child: Text('post',
                    style: Theme.of(context).textTheme.subtitle1
                )),
              ],
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if(state is ImageStatusUploadLoadingState)
                      LinearProgressIndicator(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage:NetworkImage('${cubit.userModel?.image}'),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${cubit.userModel?.name}',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  height: 1.5
                              ),
                            ),
                            SizedBox(height: 10,),
                            // Text('20 Augast, 2023 at 11.00 pm',
                            //   style: Theme.of(context).textTheme.caption?.copyWith(
                            //       height: 0.5
                            //   ),
                            // ),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: statusTextController,
                        decoration: InputDecoration(
                            hintText: 'what is in your mind .....',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    cubit.pickStatusImage!=null?
                    Expanded(child:
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Card(

                        clipBehavior:Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        child: Image.memory(cubit.pickStatusImage!,
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
                              color: Colors.deepOrange,
                            ),
                            child:cubit.pickStatusImage==null?TextButton(
                                onPressed: (){
                                  cubit.PickStatusImage();
                                },
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Text('Add photo',
                                      style:  Theme.of(context).textTheme.subtitle1?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )

                            )
                                :TextButton(
                                onPressed: (){
                                  cubit.uploadStatusImage();
                                },
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Text('Done',
                                      style:  Theme.of(context).textTheme.subtitle1?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )

                            ),
                          ),
                        ),
                        SizedBox(width:7 ,),
                        Expanded(child:
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange
                          ),
                          child: TextButton(child: Text('video',
                            style:  Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: Colors.white,
                            ),),onPressed: (){},),
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
