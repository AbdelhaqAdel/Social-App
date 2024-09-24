import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/add_post_repo.dart';

class UploadPostImageUseCase extends UseCase<void, NoParam,String>{
  AddPostRepo addPostRepo;
  UploadPostImageUseCase({required this.addPostRepo});
  @override
 Future<Either<String, void>> call([NoParam? param]) {
    return addPostRepo.uploadPostImage();
  }
}