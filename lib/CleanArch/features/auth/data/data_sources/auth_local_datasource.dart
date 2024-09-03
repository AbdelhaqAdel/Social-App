abstract class IAuthLocalDatasource{
  Future<void>getUserData({required String token});
}
class LocalDataSource implements IAuthLocalDatasource{
  @override
  Future<void> getUserData({required String token}) async{
    //TODO implement get user data From local
    throw UnimplementedError();
  }
}