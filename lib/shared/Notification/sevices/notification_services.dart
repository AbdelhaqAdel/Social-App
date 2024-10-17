import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newapp/CleanArch/core/utils/api_constatnts.dart';
import 'package:newapp/shared/Notification/notification_data_model.dart';
import 'package:newapp/shared/Notification/notification_model.dart';

Future<void> sendNotification({String? fcmToken,required NotificationModel notification,NotificationDataModel? data}) async {

    final Map<String, dynamic> body = {
    "message": {
      if (fcmToken != null)
        "token": fcmToken 
      else
        "topic": "all", 
      "notification":notification.toMap(),
      if(data != null)
      "data":data.toMap(),
    }
  };

  final response = await http.post(
    Uri.parse(ApiConstants.notifyUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ApiConstants.notifyToken}}',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.statusCode}');
  }
}
