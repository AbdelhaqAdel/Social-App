import 'package:get_it/get_it.dart';
import 'package:newapp/CleanArch/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:newapp/CleanArch/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:newapp/CleanArch/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/post_data_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/posts_local_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/data_sources/postss_remote_datasource.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/add_post_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_comment_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_like_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/create_post_usecase.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/pick_post_image_usescase.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/upload_post_image_usecase.dart';

final getIt=GetIt.instance;
void setupLocator(){
  getIt.registerSingleton<AuthRepository>(AuthRepository
    (remoteDataSource: RemoteDataSource(),localDataSource: LocalDataSource()));

    getIt.registerSingleton<PostRepository>(PostRepository
    (postRemoteDataSource: PostRemoteDatasourceImpl(),postLocalDatasource: PostLocalDatasourceImpl(), 
    postData: PostDataRemoteDatasourceImpl()));

   getIt.registerSingleton<PostLikeRepository>(PostLikeRepository
    (postsRepo: PostRemoteDatasourceImpl()));

   getIt.registerSingleton<PostCommentRepository>(PostCommentRepository
    (postsRepo: PostRemoteDatasourceImpl()));
   
   AddPostRepoImpl addPostRepoImpl=AddPostRepoImpl();
   getIt.registerSingleton<CreatePostUseCase >(CreatePostUseCase 
    (addPostRepo:addPostRepoImpl, 
    pickPostImageUseCase: PickPostImageUseCase(addPostRepo: addPostRepoImpl), 
    uploadPostImageUseCase: UploadPostImageUseCase( addPostRepo: addPostRepoImpl), ));
   
}
