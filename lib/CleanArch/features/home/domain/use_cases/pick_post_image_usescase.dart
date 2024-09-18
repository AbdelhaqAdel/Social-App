import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/features/home/domain/repositories/add_post_repo.dart';

class PickPostImageUseCase extends UseCase<XFile, NoParam>{
  AddPostRepo addPostRepo;
  PickPostImageUseCase({required this.addPostRepo});
  @override
 Future<Either<String, XFile>> call([NoParam? param]) {
    return addPostRepo.pickPostImage();
  }
}