import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.authRepository}) : super(AuthInitial());
  static ProfileCubit get(context)=>BlocProvider.of(context);
  final ProfileRepository authRepository;
  // final UploadProfileImageUseCase uploadProfileImageUseCase;

  Future<void> getUserData({required String uid})async{
   emit(GetUserDataLoadingState());
  final response=await authRepository.getUserProfile(uid: uid); 
  response.fold((errMessage) => emit(GetUserDataErrorState(errMessage: errMessage.message)),
   (userData)=> emit(GetUserDataSuccessState(userData: userData))
  );}

  Uint8List? image;
  String? pickedProfileImage;
  pickProfileImage()async{
    emit(ImageProfilePickedLoadingState());
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      pickedProfileImage=file.path;
      image=await file.readAsBytes();
      emit(ImageProfilePickedSuccessState());
    }
    else{
      emit(ImageProfilePickedErrorState());
    }
  }

  String? uploadedProfileImage;
  Uint8List? coverImage;
  String? pickedCoverImage;
  pickCoverImage()async{
    emit(ImageCoverPickedLoadingState());
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
      pickedCoverImage=file.path;
      coverImage=await file.readAsBytes();
      emit(ImageCoverPickedSuccessState());
    }
    else{
      print('no image selected');
      emit(ImageCoverPickedErrorState());

    }
  }

  String? uploadedCoverImage;
Future<String?> uploadImage({
  required String? pickedImagePath,
  required String imageType,
}) async {
  if (pickedImagePath != null) {
    try {
      emit(ImageUploadLoadingState());
      final uploadTask = await firebase_storage.FirebaseStorage
          .instance
          .ref()
          .child('users/${Uri.file(pickedImagePath).pathSegments.last}')
          .putFile(File(pickedImagePath));
      String downloadURL = await uploadTask.ref.getDownloadURL();
      emit(ImageUploadSuccessState());
      return downloadURL;
    } catch (e) {
      emit(ImageUploadErrorState());
      print('Error uploading $imageType image: $e');
      return null;
    }
  } else {
    return null;
  }
}

Future<void> updateUserInfo({
  required String name,
  required String phone,
  required String bio,
  String? nickname,
}) async {
  try {
    emit(UserUpdateLoadingState());

    uploadedProfileImage = await uploadImage(
      pickedImagePath: pickedProfileImage,
      imageType: "profile",
    );

    uploadedCoverImage = await uploadImage(
      pickedImagePath: pickedCoverImage,
      imageType: "cover",
    );

    UserModel model = UserModel(
      name: name,
      email: userData?.email,
      uId: uid,
      phone: phone,
      image: uploadedProfileImage ?? userData?.image,
      bio: bio,
      cover: uploadedCoverImage ?? userData?.cover,
      nickname: nickname ?? userData?.nickname,
    );

    await FirebaseFirestore.instance
        .collection(kUsers)
        .doc(model.uId)
        .update(model.toMap());

    emit(UserUpdateSuccessState());

    await getUserData(uid: uid);
  } catch (e) {
    print('Error during update: $e');
    emit(UserUpdateErrorState());
  }
}

}

