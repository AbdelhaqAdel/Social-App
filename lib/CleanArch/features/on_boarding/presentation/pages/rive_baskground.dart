import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveBackground extends StatelessWidget {
  const RiveBackground({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return  Stack(
            children: [
              Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const RiveAnimation.asset(
                      "assets/rive/backgroundRive.riv",
             ),
                  ),
                ],
              ),
              Positioned(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 135, sigmaY: 135),
                    child: const SizedBox(),
                  )),
              SafeArea(
                child: widget,
               ),
            ],
          );
   
  }
}