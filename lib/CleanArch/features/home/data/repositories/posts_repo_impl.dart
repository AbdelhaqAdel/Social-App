import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/posts_local_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/postss_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/post.dart';


class PostRepository extends PostRepo{
  final PostRemoteDatasourceImpl postRemoteDataSource;
  final PostLocalDatasourceImpl postLocalDatasource;
  PostRepository({required this.postRemoteDataSource,required this.postLocalDatasource});
  @override
  // Future<Either<Failure, List<CoursesModel>>> getAllCourses() async{
  // try{
  //   //  List<CoursesModel>cachedCourses = await coursesLocalDatasource
  //   //      .fetchCoursesFromHive();
  //   //  if(cachedCourses.isNotEmpty){
  //   //    return right(cachedCourses);
  //   //  }
  //  List<CoursesModel>courses=await coursesDataSource.fetchCourses();
  //   return right(courses);
  // }catch(error){
  //   if(error is DioException){
  //     return left(ServerFailure.fromDiorError(error));
  //   }else{
  //     return left(ServerFailure(error.toString()));
  //   }
  //  }
  // }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }
}