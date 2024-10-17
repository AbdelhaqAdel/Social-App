import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/features/notification/data/NotificationModelAndAdabpter/notify_model.dart';

class NotifyServices{
  
 static final Box notifyBox = Hive.box(HiveConstants.notifyBox);

 static void storeNotifyToHive({
    required String title,
    required String body,
  }) {
    List<NotifyModel> notifyList =
    notifyBox.get(HiveConstants.notifyBox, defaultValue: []).cast<NotifyModel>();
    notifyList.add(
        NotifyModel(
          hiveIndex: notifyList.length,
          notifyTitle:title,
          notifyBody:body,
          notifyTime:DateFormat("yyyy-MM-dd 'at' HH:mm").format(DateTime.now())
        ));
    notifyBox.put(HiveConstants.notifyBox, notifyList);
  }

}