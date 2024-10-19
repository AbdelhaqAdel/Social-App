import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';
import 'package:newapp/CleanArch/features/stories/domain/use_cases/add_user_status_use_case.dart';
import 'package:newapp/CleanArch/features/stories/domain/use_cases/get_user_status_use_case.dart';
import 'package:newapp/CleanArch/features/stories/domain/use_cases/get_users_added_status_use_case.dart';

part 'story_state.dart';

class StatusCubit extends Cubit<StatusState> {
static StatusCubit get(context)=>BlocProvider.of(context);   

 final GetUserStatusUseCase getAllStatusUseCase;
 final AddUserStatusUseCase addUserStatusUseCase;
 final GetUserAddedStatusUseCase getAddedStatusUseCase;
  StatusCubit({required this.getAllStatusUseCase,required this.addUserStatusUseCase
  ,required this.getAddedStatusUseCase}) : super(StatusInitial());


List<Map<String, dynamic>> allStatus=[];
  void fetchAllStatuses() {
    emit(GetAllStatusLoadingState());
    final result=getAddedStatusUseCase.call();
    result.fold(
      (l) => emit(GetAllStatusErrorState(l.message)),
      (allStatus){
        allStatus.listen((status) {
          this.allStatus=status;
         emit(GetAllStatusSuccessState(status));
        });
      }
      );
  }
  

List<StatusModel> userStatus=[];
  void fetchUserStatuses({required String userId}) {
    emit(GetUserStatusLoadingState());
    final result=getAllStatusUseCase.call(userId:userId );
    result.fold(
      (l) => emit(GetUserStatusErrorState(l.message)),
      (userStatus){
        userStatus.listen((status) {
          this.userStatus=status;
         emit(GetUserStatusSuccessState(status));
        });
      }
      );
  }
  

 Future< void> addUserStatus({required String statusText})async{
    emit(AddStatusLoadingLoadingState());
   final result=await addUserStatusUseCase.call(text: statusText,statusColor: statusColor[colorIndex]);  
   result.fold((l) =>emit(AddStatusErrorState(l.message)),
    (r) {
      fetchAllStatuses();
      emit(AddStatusSuccessState());} );
  }

 int colorIndex=2;
  List<Color>statusColor=[
    Colors.blueAccent,
    Colors.deepPurple,
    Colors.indigo,
    Colors.deepOrange,
  ];
  void changeCurrentStatusColorIndex(){
    if(colorIndex< statusColor.length-1) {
      colorIndex = colorIndex + 1;
    }
    else {
      colorIndex=0;
    }
    emit(ChangeStatusColorIndex());
  }
}
