import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/core/utils/hive_services.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';

abstract class IProfileLocalDataSource{
  Future<RegisterModel>getUserData();
}
class ProfileLocalDataSource implements IProfileLocalDataSource{
  @override
  Future<RegisterModel> getUserData() async{
     RegisterModel user;
     user=await HiveServices.get(boxName: HiveConstants.userDataBox, key:HiveConstants.userDataBox );
     userModel=user;
     userImage=user.image??'';
     print('user image : ${userModel?.name}');
     return user;
  }
}