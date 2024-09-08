import 'package:get_it/get_it.dart';
import 'package:newapp/CleanArch/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:newapp/CleanArch/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:newapp/CleanArch/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/post_data_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/posts_local_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/postss_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_reaction_reo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';

final getIt=GetIt.instance;
void setupLocator(){
  getIt.registerSingleton<AuthRepository>(AuthRepository
    (remoteDataSource: RemoteDataSource(),localDataSource: LocalDataSource()));

    getIt.registerSingleton<PostRepository>(PostRepository
    (postRemoteDataSource: PostRemoteDatasourceImpl(),postLocalDatasource: PostLocalDatasourceImpl(), 
    postData: PostDataRemoteDatasourceImpl()));

   getIt.registerSingleton<PostReactoinRepository>(PostReactoinRepository
    (postsRepo: PostRemoteDatasourceImpl()));

   
}
