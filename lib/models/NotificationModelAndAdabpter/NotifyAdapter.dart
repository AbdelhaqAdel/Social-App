import 'package:hive/hive.dart';

import 'NotificationHiveModel.dart';


class StuHistoryAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 0; // Unique identifier for this type adapter

  @override
  NotificationModel read(BinaryReader reader) {
    return NotificationModel(
      hiveIndex: reader.readInt(),
      notifyMessage: reader.readString(),
      notifyTime: reader.readString(),

    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer.writeInt(obj.hiveIndex ?? 0);
    writer.writeString(obj.notifyMessage ?? '');
    writer.writeString(obj.notifyTime ?? '');

  }
}