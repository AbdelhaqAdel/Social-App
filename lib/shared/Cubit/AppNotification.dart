import 'package:firebase_messaging/firebase_messaging.dart';

class AppNotification{

// create instance from firebase messaging
  final _firebaseMessaging=FirebaseMessaging.instance;

//initialize notification for the app
  Future<void> initNotification()async{
    await _firebaseMessaging.requestPermission();
    String? MToken =await _firebaseMessaging.getToken().then((value) {
      print('FBM TOKEN ---------------------- $value');

    }).catchError((onError){
      print('notification error $onError');
          });
      }

//handle notification when recieved
//handle it when app closed


}