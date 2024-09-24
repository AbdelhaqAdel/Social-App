import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/features/chat/domain/use_cases/add_message_use_case.dart';
import 'package:newapp/CleanArch/features/chat/domain/use_cases/get_all_users_use_case.dart';
import 'package:newapp/CleanArch/features/chat/domain/use_cases/get_messages_use_case.dart';
import 'package:newapp/CleanArch/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:newapp/CleanArch/features/chat/presentation/widgets/all%20users/users_builder.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(addMessageUseCase:getIt.get<AddMessageUseCase>(),
         getMessagesUseCase: getIt.get<GetMessagesUseCase>(),
          getAllUsersUseCase: getIt.get<GetAllUsersUseCase>())..getAllUsers(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Chats',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColor.titleText, fontSize: 22.sp),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Container(
                padding: EdgeInsetsDirectional.all(6.sp),
                child:const UsersBuilder(),
            ),
          );
        },
      ),
    );
  }
}
