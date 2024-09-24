// presentation/cubit/chat_state.dart


part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class AddChatLoadingState extends ChatState {}

class AddChatSuccessState extends ChatState {}

class AddChatErrorState extends ChatState {}

class GetAllMessagesLoadingState extends ChatState {}

class GetAllMessagesSuccessState extends ChatState {
  final List<MessagesModel> messages;
  GetAllMessagesSuccessState(this.messages);
}

class GetAllMessagesErrorState extends ChatState {}

class GetUserLoadingState extends ChatState {}

class GetUserSuccessState extends ChatState {
  static List<UserModel>allUsers=[];
  static void setAllUsers(List<UserModel>users){
    allUsers=users;
  }
}

class GetUserErrorState extends ChatState {}