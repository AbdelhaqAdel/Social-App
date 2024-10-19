import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/data_model.dart';

Widget buildBoarditem(boardingModel model,context) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage(model.image),
      ),
    ),
     SizedBox(
      height: MediaQuery.of(context).size.height/22,
    ),
    Text(
      model.title,
      style:  TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22.sp,
      ),
    ),
     SizedBox(
      height: MediaQuery.of(context).size.height/35,
    ),
    Text(
      model.body,
      style:  TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ),
    ),
  ],
);
