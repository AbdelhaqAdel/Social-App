import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/add_post_repo.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/pick_post_image_usescase.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/upload_post_image_usecase.dart';

class CreatePostUseCase extends UseCase<void, String>{

  final AddPostRepo addPostRepo;
  final PickPostImageUseCase pickPostImageUseCase;
  final UploadPostImageUseCase uploadPostImageUseCase;
  CreatePostUseCase({required this.addPostRepo,required this.pickPostImageUseCase,
  required this.uploadPostImageUseCase,});
  @override
 Future<Either<String, void>> call([String? param]) {
    return addPostRepo.addPost(postText: param!);
  }
}