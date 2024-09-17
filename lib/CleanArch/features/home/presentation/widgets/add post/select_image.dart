import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class SelectImageButton extends StatefulWidget {
  const SelectImageButton({super.key});
  @override
  State<SelectImageButton> createState() => _SelectImageButtonState();
}
 
class _SelectImageButtonState extends State<SelectImageButton> {
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
               child:AppCubit.get(context).pickPostImage!=null
               ?   IconButton(
                   onPressed: (){
                     AppCubit.get(context).uploadPostImage();
                   },
                   icon:Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        const Icon(Icons.done_outline,color: Colors.white,),
                        const SizedBox(width: 5,),
                             Text('Done',
                               style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColor.whiteColor,
                               ),
                             ),
                           ],
                         )
                     )
                     :IconButton(
                         onPressed: (){
                           AppCubit.get(context).PickPostImage().then((value) {
                             setState(() {
                                // AppCubit.get(context).pickPostImage=
                              });
                            });
                          },
                          icon:Row(
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
              ),
                  ),
                    ],
                  );
          
  }
}