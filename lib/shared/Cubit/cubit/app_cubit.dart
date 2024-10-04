import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/profile/presentation/pages/profile_screen.dart';
import '../../../CleanArch/features/home/presentation/pages/add_post_screen.dart';
import '../../../CleanArch/features/home/presentation/pages/posts_screen.dart';
import '../../../CleanArch/features/stories/presentation/pages/status_screen.dart';
import '../../../CleanArch/features/chat/presentation/pages/all_chats_screen.dart';
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
    PostsScreen(),
    const MessagesScreen(),
    AddPostScreen(),
    const StatusScreen(),
    const ProfileScreen()
  ];
  int currentIndex=0;
  void ChangeCurrentIndex(int index){

       currentIndex=index;
   emit(ChangeCurrentIndexState());
  }


}