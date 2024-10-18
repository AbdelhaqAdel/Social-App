import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
              var screenSize=MediaQuery.of(context).size;
    return     SizedBox(
                        height:screenSize.height/3.5,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children:[
                            FadeIn(
                            delay: const Duration(milliseconds:500),
                            // from: 100,
                              child: Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: SizedBox(
                                  width: double.infinity,
                                  height:screenSize.height/4.5,
                                  child: Card(
                                    elevation: 10,
                                    child: Image.network('${userData?.cover}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FadeInUp(
                            delay: const Duration(milliseconds:500),
                            from: 100,
                              child: CircleAvatar(
                                backgroundColor:HexColor('#13003b'),
                                radius: screenSize.width/7,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${userData?.image}'),
                                  radius: screenSize.width/7.5,
                                                      ),
                              ),
                            ),
                            ]
                        ),
                      );  }
}