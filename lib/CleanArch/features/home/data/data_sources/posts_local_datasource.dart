
import 'package:hive/hive.dart';
import 'package:newapp/CleanArch/core/utils/hive_constant.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';


abstract class PostLocalDataSource {
  Future<List<PostModel>> fetchPostsFromHive();
}
class PostLocalDataSourceImpl extends PostLocalDataSource{
  @override
  Future<List<PostModel>> fetchPostsFromHive() async {
  var box= Hive.box<PostModel>(HiveConstants.postBox);
     return box.values.toList();
  }

}