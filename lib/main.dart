import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/LayoutScreens/ChatLayoutScreen.dart';
import 'package:newapp/modules/UserScreens/UserRegister/RegisterScreen.dart';
import 'package:newapp/modules/test.dart';
import 'package:newapp/shared/Constants/KeyConstants.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:newapp/shared/Styles/themes.dart';
import 'package:newapp/shared/network/local/CacheHelper.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'modules/UserScreens/UserLogin/LoginScreen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var MToken=await FirebaseMessaging.instance.getToken();
  print('device token : $MToken');
  FirebaseMessaging.onMessage.listen((event) {
    print('on meaasage data :${event.data.toString()}');
    //print(event.notification)
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on meaasage opened app data :${event.data.toString()}');
    //print(event.notification)
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CacheHelper.init();

  Widget startWidget;

  uid=CacheHelper.getData('uid');
  //print('UID: ${uid}');

  if(uid != null){
    startWidget=ChatLyaout();
  }
  else{
    startWidget=LoginSreen();
  }


  runApp(MyApp(
      startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget ?StartWidget;
  MyApp(this.StartWidget);
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (BuildContext context)=>AppCubit()..GetUserData()..GetAllPosts()..whoUserAddStory(),
      child: BlocConsumer<AppCubit,AppState>(
        listener:(context,state){} ,
        builder: (context,state){
          return   MaterialApp(
            debugShowCheckedModeBanner: false,
            // Set up your app's properties here, such as theme, title, etc.
            title: 'My App',
            theme: lightTheme,
          //  darkTheme:darkTheme,
            themeMode: ThemeMode.light,
           // appcubit.get(context).isDark ?ThemeMode.dark :
           //  theme: ThemeData(
           //    primarySwatch: Colors.blue,
           //  ),
            home: StartWidget,
          );
        },
      ),
    );


  }
}

// class TestScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(create: (BuildContext context)=>AppCubit()..testprint(),
//       child: BlocConsumer<AppCubit,AppState>(
//         listener:(context,state){} ,
//         builder: (context,state){
//          return Scaffold(
//             appBar: AppBar(
//               title: Text('Test Screen'),
//             ),
//             body: Center(
//               child: Text('Hello, World!'),
//             ),
//           );
//         },
//       ),
//     );
//   }



