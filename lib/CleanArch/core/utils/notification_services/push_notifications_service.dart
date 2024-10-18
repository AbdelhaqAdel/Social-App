import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:newapp/CleanArch/core/functions/store_to_notification.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/utils/notification_services/local_notifications_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      fcmToken=value;
    });
    messaging.onTokenRefresh.listen((value){
      sendTokenToServer(value);
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    handleForegroundMessage();
    messaging.subscribeToTopic('all').then((val){
      print('Subscription');
    });
       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
       isNotifyOpened=false;
        NotifyServices.storeNotifyToHive(title:message.notification!.title??'',body:message.notification!.body??'');
      }
    });
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'null');
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        LocalNotificationService.showBasicNotification(
          message,
        );
      },
    );
  }
  static void sendTokenToServer(String token) {
  }
}
