import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
 final TextEditingController controller;
 final String hintText;
 final String labelText;
 final bool isPassword;
 final TextInputType keyboardType;
 final Widget? suffix;
 final Widget? prefix;
 final int? maxLines;
 final String? Function(String?)? validator;
 final Function(PointerDownEvent)? onTapOutside;
 final Color backgroundColor;
 final Color? outLineBorderColor;
 final Color?focusedBorderColor;
 final double? border;
 final double sizedBoxHeight;
 final double sizedBoxWidth;
 final bool enabled;
  final double? hintTextFontSize;

  CustomFormField(
      {super.key,
      required this.controller,
      this.hintText = '',
      this.labelText = '',
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.suffix,
      this.prefix,
      this.maxLines = 1,
      this.validator,
      this.backgroundColor = Colors.white,
      this.outLineBorderColor,
      this.focusedBorderColor,
      this.onTapOutside,
      this.border,
      this.sizedBoxHeight = 0.0,
      this.sizedBoxWidth = 0.0,
      this.enabled = true,
      this.hintTextFontSize,
      });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 20,
          ),
          onTapOutside: onTapOutside,
          validator: validator,
          maxLines: maxLines,
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(
                  fontSize: hintTextFontSize,
                  color: const Color(0xffAAAAAA)),
            fillColor: backgroundColor,
            filled: true,
            enabled: enabled,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border ?? 10),
              borderSide: BorderSide(color:focusedBorderColor?? backgroundColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border ?? 10),
              borderSide: BorderSide(color: backgroundColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border ?? 10),
              borderSide: BorderSide(color:outLineBorderColor?? backgroundColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border ?? 10),
              borderSide: BorderSide(color: backgroundColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border ?? 10),
              borderSide: BorderSide(color: backgroundColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border ?? 10),
              borderSide: BorderSide(color: backgroundColor),
            ),
            suffixIcon: suffix,
            prefixIcon: prefix,
          ),
        
        ),
        SizedBox(height: sizedBoxHeight.h,),
        SizedBox(height: sizedBoxWidth.w,),
      ],
    );
  }
}
