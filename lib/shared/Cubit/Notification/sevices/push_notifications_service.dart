import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:newapp/shared/Cubit/Notification/sevices/local_notifications_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      log(value!);
      sendTokenToServer(value);
    });
    messaging.onTokenRefresh.listen((value){
      sendTokenToServer(value);
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    //foreground
    handleForegroundMessage();
    messaging.subscribeToTopic('all').then((val){
      log('sub');
    });

    // messaging.unsubscribeFromTopic('all');
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'null');
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // show local notification
        LocalNotificationService.showBasicNotification(
          message,
        );
      },
    );
  }

  static void sendTokenToServer(String token) {
    // option 1 => API 
    // option 2 => Firebase 
  }
}
/*
  1.Permissions [done]
  2.fcm token [done]
  3.test using token with Firebase [done]
  4.fire notification [background] [done]
  5.fire notification [killed] [done]
  6.fire notification [foreground] [done]
  7.test using token with Postman [done]
  8.send Image with notification [done]
  9.send notfification with custom sound [done]
  10.send token to server [done]
  11.topic [done]
 */