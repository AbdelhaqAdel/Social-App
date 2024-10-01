import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/core/utils/set_up_hive.dart';
import 'package:newapp/CleanArch/features/auth/presentation/pages/login_screen.dart';
import 'package:newapp/CleanArch/generated/bloc_observer.dart';
import 'package:newapp/CleanArch/layout.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'package:newapp/shared/Styles/themes.dart';
import 'package:newapp/shared/network/DioHelper.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
import 'firebase_options.dart';
import 'models/NotificationModelAndAdabpter/NotifyAdapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.data.toString()}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  AppNotification().initNotification();
    Bloc.observer = MyBlocObserver();

  // final _firebaseMessaging=FirebaseMessaging.instance;
  // await _firebaseMessaging.requestPermission().then((value){
  //   print('permission----------------------------');
  //    FirebaseMessaging.instance.subscribeToTopic('all');
  // });
  // // _firebaseMessaging.requestPermission(
  // //   alert: true,
  // //   announcement: false,
  // //   badge: true,
  // //   carPlay: false,
  // //   criticalAlert: false,
  // //   provisional: false,
  // //   sound: true,
  // // );
  // await _firebaseMessaging.getToken().then((value) {
  //   print('device token -------: $value');
  // });
  // //when app is open
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('on message data :${event.notification.toString()}');
  //   print('on message from :${event.from.toString()}');
  //   //print(event.notification)
  // });
  //  //when click on notification to open app
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('on meaasage opened app data :${event.data.toString()}');
  //   //print(event.notification)
  // });
  // //background FCM
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupHive();
  setupLocator();
  await CacheHelper.init();
  Dio_Helper.init();
  Widget startWidget;
  if(uid != ''){
    startWidget=const LayoutScreen();
  }
  else{
    startWidget=LoginScreen();
  }
  runApp(MyApp(
      startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget ?StartWidget;
  MyApp(this.StartWidget);
  @override
  Widget build(BuildContext context){
    return  BlocProvider(create: (BuildContext context)=>AppCubit(),
    // ..GetUserData()
    //  ..whoUserAddStory(),
      child: BlocConsumer<AppCubit,AppState>(
        listener:(context,state){} ,
        builder: (context,state){
          return  ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_ , child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'My App',
            theme: lightTheme,
            themeMode: ThemeMode.light,
            routerConfig: AppRouter.router,
            // home: StartWidget,
          );});
        },
      ),
    );


  }
}


