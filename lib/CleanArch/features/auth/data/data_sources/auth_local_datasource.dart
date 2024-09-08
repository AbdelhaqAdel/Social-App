import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/core/utils/hive_services.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';

abstract class IAuthLocalDatasource{
  Future<RegisterModel>getUserData();
}
class LocalDataSource implements IAuthLocalDatasource{
  @override
  Future<RegisterModel> getUserData() async{
     RegisterModel user;
     user=await HiveServices.get(boxName: HiveConstants.userDataBox, key:HiveConstants.userDataBox );
     userModel=user;
     userImage=user.image??'';
     return user;
  }
}