import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class AddStatusScreen extends StatelessWidget {
  final TextEditingController statusTextController =TextEditingController();

  AddStatusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener:(context,state){},
        builder:(context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.layoutBackgroundColor,
              title: Text("Create your story",style: Theme.of(context).textTheme.titleMedium,),
              actions: [
                TextButton(onPressed: (){
                  cubit.AddUsersStatus(
                    statusText:statusTextController.text,
                  );
                  Navigator.pop(context);
                }, child: Text('post',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColor.titleText)
                )),
              ],
               leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                         icon: const Icon(Icons.arrow_back_ios,color: AppColor.whiteColor,),
                      ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if(state is ImageStatusUploadLoadingState)
                    const LinearProgressIndicator(),
                SizedBox(height: 20.h,),
                  SizedBox(
                    height: 40.h,
                    child: TextFormField(
                      controller: statusTextController,
                      decoration: const InputDecoration(
                          hintText: 'what is in your mind .....',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  cubit.pickStatusImage!=null?
                  Expanded(child:
                  SizedBox(
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
                      :const SizedBox(),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height/18,
                          decoration: BoxDecoration(
                        color: AppColor.layoutBackgroundColor
                          ),
                          child:cubit.pickStatusImage==null?TextButton(
                              onPressed: (){
                                cubit.PickStatusImage();
                              },
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image,color: Colors.white,),
                                   SizedBox(width: 5.w,),
                                  Text('Add photo',
                                    style:  Theme.of(context).textTheme.titleMedium?.copyWith(
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
                                  const Icon(Icons.image,color: Colors.white,),
                                  const SizedBox(width: 5,),
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
                      const SizedBox(width:7 ,),
                      Expanded(child:
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                        color: AppColor.layoutBackgroundColor
                        ),
                        child: TextButton(child: Text('video',
                          style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),),onPressed: (){},),
                      ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
          },
    );
  }
}
