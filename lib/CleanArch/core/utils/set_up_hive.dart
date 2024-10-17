import 'package:hive_flutter/adapters.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';
import 'package:newapp/CleanArch/features/notification/data/NotificationModelAndAdabpter/notify_adapter.dart';

Future<void> setupHive()async{
  await Hive.initFlutter();
  Hive.registerAdapter(NotifyAdapter());
    await Hive.openBox(HiveConstants.notifyBox);
  Hive.registerAdapter(RegisterModelAdapter());
   await Hive.openBox(HiveConstants.userDataBox);
}