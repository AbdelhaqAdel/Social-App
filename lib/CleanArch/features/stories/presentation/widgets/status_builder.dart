import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/stories/presentation/manager/cubit/story_cubit.dart';
import 'package:newapp/CleanArch/features/stories/presentation/widgets/status_list_view.dart';

class StatusBuilder extends StatelessWidget {
  const StatusBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit,StatusState>(builder:(context,state){
      if(StatusCubit.get(context).status.isNotEmpty){
        return StatusListView(status:StatusCubit.get(context).status );
       }else if(state is GetAllStatusLoadingState){
        return const Center(child: CircularProgressIndicator());
       }else if(state is GetAllStatusErrorState){
        return Center(child: Text(state.message));
       }else{
        return const Center(child: Text('No Status Now'),);
       }
    }
     
     );
  }
}