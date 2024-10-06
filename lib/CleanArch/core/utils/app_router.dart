import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/auth/presentation/pages/login_screen.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/chat/presentation/pages/chat_screen.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/features/profile/presentation/manager/profile_cubit.dart';
import 'package:newapp/CleanArch/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:newapp/CleanArch/features/stories/presentation/manager/cubit/story_cubit.dart';
import 'package:newapp/CleanArch/features/stories/presentation/pages/add_text_status_screen.dart';
import 'package:newapp/CleanArch/features/stories/presentation/pages/show_status.dart';
import 'package:newapp/CleanArch/layout.dart';

abstract class AppRouter{
    static const kLogin = '/';
    static const kLayout = '/LayoutScreen';
    static const kChatScreen = '/ChatScreen';
    static const kWriteStatus = '/TextStatusScreen';
    static const kShowStatus = '/ShowStatus';
    static const kEditProfile = '/EditProfileScreen';



    static BuildContext? cubitContext;

    static final router = GoRouter(
      navigatorKey:navigatorKey,
    routes: [
      GoRoute(
        path: kLogin,
        builder: (context, state) => LoginScreen(),
     ),
     GoRoute(
        path: kLayout,
        builder: (context, state) => const LayoutScreen(),
     ),
     GoRoute(
        path: kChatScreen,
       builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          final String userId = data['userId'];
          final UserModel receiver = data['receiver'] as UserModel;
        
         return BlocProvider.value(
           value: cubitContext!.read<ChatCubit>()..getMessages(userId:userId ),
           child:  ChatScreen(receiverModel: receiver,),
         );
       },
     ),

     GoRoute(
        path: kWriteStatus,
       builder: (context, state) {
         return BlocProvider.value(
           value: cubitContext!.read<StatusCubit>(),
           child:  TextStatusScreen(),
         );
       },
     ),

        GoRoute(
        path: kShowStatus,
       builder: (context, state) {
         return BlocProvider.value(
           value: cubitContext!.read<StatusCubit>()..fetchUserStatuses(userId: state.extra as String),
           child:  const ShowStatus(),
         );
       },
     ),

         GoRoute(
        path: kEditProfile,
       builder: (context, state) {
         final UserModel userModel = state.extra as UserModel;   
         return BlocProvider.value(
           value: cubitContext!.read<ProfileCubit>(),
           child:  EditProfileScreen(userModel: userModel,),
         );
       },
     ),
     ]
      );
}