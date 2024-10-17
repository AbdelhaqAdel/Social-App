import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
class PostImageCard extends StatelessWidget {
  const PostImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return     Expanded(child:SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Card(
                            clipBehavior:Clip.antiAliasWithSaveLayer,
                            elevation: 10,
                            child:Image.memory(PostCubit.get(context).imageAsByte!,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ),
                      );
              
  }
}