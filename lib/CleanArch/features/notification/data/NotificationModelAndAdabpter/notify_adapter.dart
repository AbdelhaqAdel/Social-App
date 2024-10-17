import 'package:hive/hive.dart';

import 'notify_model.dart';


class NotifyAdapter extends TypeAdapter<NotifyModel> {
  @override
  final int typeId = 1;

  @override
  NotifyModel read(BinaryReader reader) {
    return NotifyModel(
      hiveIndex: reader.readInt(),
      notifyTitle: reader.readString(),
      notifyBody:reader.readString(),
      notifyTime: reader.readString(),

    );
  }

  @override
  void write(BinaryWriter writer, NotifyModel obj) {
    writer.writeInt(obj.hiveIndex ?? 0);
    writer.writeString(obj.notifyTitle ?? '');
    writer.writeString(obj.notifyBody??'');
    writer.writeString(obj.notifyTime ?? '');

  }
}