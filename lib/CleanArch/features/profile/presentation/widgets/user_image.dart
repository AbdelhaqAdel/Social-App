import 'package:flutter/cupertino.dart';
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
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: SizedBox(
                                width: double.infinity,
                                height:screenSize.height/4.5,
                                child: Card(
                                  elevation: 10,
                                  child: Image.network('${userModel?.cover}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor:HexColor('#13003b'),
                              radius: screenSize.width/8,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('${userModel?.image}'),
                                radius: screenSize.width/8.5,
                          ),
                            ),
                            ]
                        ),
                      );  }
}