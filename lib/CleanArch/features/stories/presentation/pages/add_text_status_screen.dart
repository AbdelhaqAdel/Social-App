import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/Cubit/cubit/app_cubit.dart';

class TextStatusScreen extends StatelessWidget {
  final statusTextController = TextEditingController();

  TextStatusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: cubit.statusColor[cubit.colorIndex],
              title:Text("create story",style: Theme.of(context).textTheme.titleMedium,),
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.AddUsersStatus(
                        statusText: statusTextController.text,
                      );
                      Navigator.pop(context);
                    },
                    child: Text('post',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 15.sp
                        ))),
              ],
            ),
            body: Container(
              color: cubit.statusColor[cubit.colorIndex],

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
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
              child: const Icon(Icons.color_lens_outlined,color: Colors.deepOrange,),
            ),
          );
        });
  }
}
