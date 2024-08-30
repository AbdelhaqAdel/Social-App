import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FavStory extends StatelessWidget {
  const FavStory({super.key});

  @override
  Widget build(BuildContext context) {
    return 
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: HexColor('#ea1a78'),
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:HexColor('#13003b'),
                                    child: const Icon(Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text('new',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),

                        );
                    
  }
}