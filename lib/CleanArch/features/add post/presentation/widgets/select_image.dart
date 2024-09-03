import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class SelectImageButton extends StatelessWidget {
  const SelectImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return          Row(
                    children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height/15,
                      decoration: BoxDecoration(
                        color: AppColor.layoutBackgroundColor
                      ),
                      child:AppCubit.get(context).pickPostImage==null?TextButton(
                          onPressed: (){
                            AppCubit.get(context).PickPostImage();
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text('Add photo',
                                  style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                   color: AppColor.whiteColor,
                                  ),
                              ),
                            ],
                          )
                      )
                          :TextButton(
                          onPressed: (){
                            AppCubit.get(context).uploadPostImage();
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text('Done',
                                style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                   color: AppColor.whiteColor,
                                ),
                              ),
                            ],
                          )

                      ),
                    ),
                  ),
                    ],
                  );
          
  }
}