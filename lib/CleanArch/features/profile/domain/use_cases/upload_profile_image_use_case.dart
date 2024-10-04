import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/usecases/use_case.dart';
import 'package:newapp/CleanArch/features/profile/domain/repositories/profile_repo.dart';

class UploadProfileImageUseCase extends UseCase<void, String,String>{
  IProfileRepo profileRepo;
  UploadProfileImageUseCase({required this.profileRepo});

  // String pickedImage='';
  @override
 Future<Either<String, void>> call([String? param]) {
    return profileRepo.uploadProfileImage(pickedImage: param!);
  }

//   Future<void> pickImage()async{
//     final result=await AppFunctions.pickImage();
//     result.fold((l) => pickedImage=l,
//      (r) => pickedImage=r.path);
//  }
}