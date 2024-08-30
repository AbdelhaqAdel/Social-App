
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/colors.dart';


PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
})=>AppBar(
  backgroundColor: AppColor.layoutBackgroundColor,
  title: Text(title??'',style: TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
  ),),
  actions: actions,
  titleSpacing: 0.5,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back_ios,color: Colors.grey,),
  ),
);


void NavigateTo(context,Widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>Widget,
  ),
);


void NavigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
      builder: (context)=>Widget,
    ),
        (route) => false
);


void ShowSnackBar(context,{required String text}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.deepOrange,
          content: Text(text)));
}