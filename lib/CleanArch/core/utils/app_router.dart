import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/features/auth/presentation/pages/login_screen.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/chat/presentation/pages/chat_screen.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/layout.dart';

abstract class AppRouter{
    static const kLogin = '/';
    static const kLayout = '/LayoutScreen';
    static const kChatScreen = '/ChatScreen';


    static BuildContext? cubitContext;

    static final router = GoRouter(
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
     ]
      );
}