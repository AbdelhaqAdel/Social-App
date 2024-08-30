import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/Cubit/cubit/app_cubit.dart';

class TextStatusScreen extends StatelessWidget {
  var statusTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: cubit.statusColor[cubit.colorIndex],
              title: Text("create story"),
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.AddUsersStatus(
                        statusText: statusTextController.text,
                        //color: cubit.statusColor[cubit.colorIndex],
                      );
                      //cubit.whoUserAddStory();
                      Navigator.pop(context);
                    },
                    child: Text('post',
                        style: Theme.of(context).textTheme.titleMedium)),
              ],
            ),
            body: Container(
              color: cubit.statusColor[cubit.colorIndex],

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child:   TextFormField(
                          controller: statusTextController,
                          decoration: InputDecoration(
                              hintText: 'Write your status.....',
                              hintStyle: Theme.of(context).textTheme.bodyLarge,
                              border: InputBorder.none
                          ),
                        ),

                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                cubit.changeCurrentStatusColorIndex();
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.color_lens_outlined,color: Colors.deepOrange,),
            ),
          );
        });
  }
}
