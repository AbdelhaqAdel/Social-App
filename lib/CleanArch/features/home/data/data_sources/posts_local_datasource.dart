
import 'package:hive/hive.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';


abstract class PostLocalDatasource {
  Future<List<PostModel>> fetchPostsFromHive();
}
class PostLocalDatasourceImpl extends PostLocalDatasource{
  @override
  Future<List<PostModel>> fetchPostsFromHive() async {
  var box= Hive.box<PostModel>(HiveConstants.postBox);
  print('getting cached data');
     return box.values.toList();
  }

}