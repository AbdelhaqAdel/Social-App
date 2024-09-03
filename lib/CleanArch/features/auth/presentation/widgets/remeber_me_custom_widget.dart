import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemeberMe extends StatelessWidget {
  final bool value;
  final Function onChanged;
  const RemeberMe({
    required this.value,
    required this.onChanged,
    super.key});

  @override
  Widget build(BuildContext context) {
    return    Padding(
        padding:  EdgeInsets.fromLTRB(0, 5, 0, 30.h),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: value,
                activeColor: Colors.blue,
                onChanged:(value){
                   onChanged(value);
                   },                
              ),
               SizedBox(height: 100.h,),
               Text(
               'Remember me',
                style: TextStyle(
                  fontSize: 18.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          );
    
  }
}