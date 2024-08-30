import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return    Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('2',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[400],
                              ),
                            ),
                            Text('Posts',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[400],
                                ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('632',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[400],
                                ),
                            ),
                            Text('Followers',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  //fontSize: 15,
                                  color: Colors.grey[400],
                                )
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('622',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  //fontSize: 15,
                                  color: Colors.grey[400],
                                )
                            ),
                            Text('Following',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  //fontSize: 15,
                                  color: Colors.grey[400],

                                )
                            )
                          ],
                        ),
                      ),
                    ],);
  }
}