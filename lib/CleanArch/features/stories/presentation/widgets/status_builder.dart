import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/stories/presentation/widgets/status_list_view.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';

class StatusBuilder extends StatelessWidget {
  const StatusBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(builder:(context,state){
      if(state is GetUserAddStatusSuccessState){
        return StatusListView(status: state.status,);
       }else if(state is GetUserAddStatusErrorState){
        return const Center(child: CircularProgressIndicator());
       }else{
        return const Text('error');
       }
    }
     
     );
  }
}