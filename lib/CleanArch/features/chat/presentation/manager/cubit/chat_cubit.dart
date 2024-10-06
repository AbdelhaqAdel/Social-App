import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';
import 'package:newapp/CleanArch/features/chat/domain/use_cases/add_message_use_case.dart';
import 'package:newapp/CleanArch/features/chat/domain/use_cases/get_all_users_use_case.dart';
import 'package:newapp/CleanArch/features/chat/domain/use_cases/get_messages_use_case.dart';
import 'package:meta/meta.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  static ChatCubit get(context)=>BlocProvider.of(context);
  final AddMessageUseCase addMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;

  ChatCubit({
    required this.addMessageUseCase,
    required this.getMessagesUseCase,
    required this.getAllUsersUseCase  
  }) : super(ChatInitial());

  Future<void> addToUserChat({
    required  UserModel receiverModel,
    required String message,
  }) async {

    emit(AddChatLoadingState());
      final result= await addMessageUseCase.call(
         receiverModel, message,
      );
      result.fold((l) => emit(AddChatErrorState()),
          (r) => emit(AddChatSuccessState()));
    }

  List<MessagesModel>messages=[];
  void getMessages({required String userId}) {
    emit(GetAllMessagesLoadingState());
    final result = getMessagesUseCase.call(userId: userId);
      result.fold((l) =>emit(GetAllMessagesErrorState()),
       (r) {
        r.listen((messages) { 
          this.messages=messages;
          emit(GetAllMessagesSuccessState(messages));
        });
       });
  }

   Future<void> getAllUsers() async {
    emit(GetUserLoadingState());
     final result=await getAllUsersUseCase.call();
     result.fold((l) => emit(GetUserErrorState()),
          (allUsers) { 
            GetUserSuccessState.setAllUsers(allUsers);
            emit(GetUserSuccessState());});    
  }
}
