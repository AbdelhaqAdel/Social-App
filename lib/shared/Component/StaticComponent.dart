
import 'package:flutter/material.dart';


PreferredSizeWidget DefaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
})=>AppBar(
  title: Text(title!,style: TextStyle(
    fontSize: 18,
  ),),
  actions: actions,
  titleSpacing: 0.5,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios),
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