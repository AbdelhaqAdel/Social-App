
import 'dart:ui';
import 'package:flutter/material.dart';

Widget glassBoxWithBorderGradiant({
  required Widget widget,
  required Color color,
  required double borderRadius,
  required double x,
  required double y,
  required Color borderColor,
  required double borderWidth,
}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: y,
          sigmaX: x,
          tileMode: TileMode.clamp,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
                color: borderColor,
                style: BorderStyle.solid,
                width: borderWidth),
          ),
          child: widget,
        ),
      ),
    );
