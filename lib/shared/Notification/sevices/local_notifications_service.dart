import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  // Initialize the notification service
  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTapNotification,
      onDidReceiveBackgroundNotificationResponse: onTapNotification,
    );
  }

  // Method triggered when user taps on notification
static onTapNotification(NotificationResponse notificationResponse) {
  streamController.add(notificationResponse);

  if (notificationResponse.payload != null) {
    Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
    navigateToSpecificScreen(data);
  }
}

  // Define navigation logic with GoRouter
  static void navigateToSpecificScreen(Map<String, dynamic> data) {
    if (data['screen'] == 'chat_screen') {

      GoRouter.of(navigatorKey.currentState!.context).go(AppRouter.kChatScreen,
       extra: {
           'userId': data['user_id'],
           'receiver':userData,
          });
    } else if (data['screen'] == 'profile_screen') {
      GoRouter.of(navigatorKey.currentContext!).go('/profile/${data['user_id']}');
    }
  }

  static void showBasicNotification(RemoteMessage message) async {
    String? imageUrl = message.notification?.android?.imageUrl;
    AndroidNotificationDetails androidNotificationDetails;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final http.Response image = await http.get(Uri.parse(imageUrl));
      BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(
          base64Encode(image.bodyBytes),
        ),
        largeIcon: ByteArrayAndroidBitmap.fromBase64String(
          base64Encode(image.bodyBytes),
        ),
      );

      androidNotificationDetails = AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: bigPictureStyleInformation,
      );
    } else {
      androidNotificationDetails = const AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
      );
    }

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    String? payload = jsonEncode(message.data);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: payload,
    );
  }
}
