import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/core/utils/notification_services/local_notifications_service.dart';
import 'package:newapp/CleanArch/core/utils/notification_services/push_notifications_service.dart';
import 'package:newapp/CleanArch/core/utils/set_up_hive.dart';
import 'package:newapp/CleanArch/features/auth/presentation/pages/login_screen.dart';
import 'package:newapp/CleanArch/generated/bloc_observer.dart';
import 'package:newapp/CleanArch/layout.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/my_app.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await Future.wait([
    PushNotificationsService.init(),
    LocalNotificationService.init(),
  ]);
    Bloc.observer = MyBlocObserver();
    navigatorKey = GlobalKey<NavigatorState>();
    scaffoldKey= GlobalKey();
   await setupHive();
  setupLocator();
  await CacheHelper.init();
  Widget startWidget;
  if(uid != ''){
    startWidget=const LayoutScreen();
  }
  else{
    startWidget=LoginScreen();
  }
  runApp(MyApp(
      startWidget:startWidget,
  ));
}

