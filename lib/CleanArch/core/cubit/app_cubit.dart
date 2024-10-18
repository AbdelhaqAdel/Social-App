import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/core/utils/widgets/snack_bar.dart';
import 'package:newapp/CleanArch/features/notification/data/NotificationModelAndAdabpter/notify_model.dart';
import 'package:newapp/CleanArch/features/profile/presentation/pages/profile_screen.dart';
import '../../features/home/presentation/pages/add_post_screen.dart';
import '../../features/home/presentation/pages/posts_screen.dart';
import '../../features/stories/presentation/pages/status_screen.dart';
import '../../features/chat/presentation/pages/all_chats_screen.dart';
part 'app_state.dart';




class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);

  List<BottomNavigationBarItem>navBarItems=[
    const BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.message),
        label: 'Chats'
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),
        label: 'Post'
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.history),
        label: 'Status'
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.person),
        label: 'Profile'
    )
  ];
  List<Widget>screens=[
    const PostsScreen(),
    const MessagesScreen(),
    const AddPostScreen(),
    const StatusScreen(),
    const ProfileScreen()
  ];
  int currentIndex=0;
  void changeCurrentIndex(int index){
   if(index==2){
    emit(AddPostState());
   }else{
   currentIndex=index;
   emit(ChangeCurrentIndexState());
  }}

  List<NotifyModel> getNotifyData() {
    emit(GetNotifyLoadingState());
   final Box stuNotifyBox = Hive.box(HiveConstants.notifyBox);
    try {
     List<NotifyModel> stuNotifyModel = List.from(
          stuNotifyBox.get(HiveConstants.notifyBox, defaultValue: [])).cast<NotifyModel>();
      emit(GetNotifySuccessState());
      return stuNotifyModel;
    } catch (error) {
      emit(GetNotifyErrorState());
      return [];
    }
  }

  void deleteNotify({required int hisIndex,required context}) async {
        emit(DeleteNotifyLoadingState());
       final Box stuNotifyBox = Hive.box(HiveConstants.notifyBox);
    List<NotifyModel> stuNotifyModel = List.from(
          stuNotifyBox.get(HiveConstants.notifyBox, defaultValue: [])).cast<NotifyModel>();
    stuNotifyModel.removeAt(hisIndex);
    await stuNotifyBox.put(HiveConstants.notifyBox, stuNotifyModel)
        .then((value) {
      getNotifyData();
      showSnackBar(context: context, message: 'one item delete from your activity',);
      emit(DeleteNotifySuccessState());
    }).catchError((error) {
      emit(DeleteNotifySuccessState());
    });
  }

}