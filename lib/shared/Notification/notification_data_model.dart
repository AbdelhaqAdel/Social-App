import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

class NotificationDataModel {
  String userId;
  String screen;
  UserModel? model;
  NotificationDataModel({required this.userId,this.model,required this.screen});
  Map<String, dynamic> toMap() {
    return {
      'screen':screen,
      'user_id': userId,
      // 'user_model': model.toMap(),
    };  
  }
}