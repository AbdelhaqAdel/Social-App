import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/shared/Notification/sevices/local_notifications_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      log(value!);
      fcmToken=value;
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
  }
}
