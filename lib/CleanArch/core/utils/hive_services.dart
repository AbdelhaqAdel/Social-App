import 'package:hive/hive.dart';
class HiveServices{
  static void saveDataToHive<ListType>(key, value, String boxName) {
    print('HIVE list type $ListType');
    var box = Hive.box(boxName);
    box.put(key,value).then((value){
      print('Hive saved all data');
    });
  }

  static Future<generateType> get<generateType>({required boxName,required key})async{
    generateType result=Hive.box(boxName).get(key);
    return result;
  }
}
