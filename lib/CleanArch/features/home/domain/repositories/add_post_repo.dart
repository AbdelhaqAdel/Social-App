import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddPostRepo{

  Future<Either<String,void>>addPost({required String postText});
  
    Future<Either<String, XFile>>  pickPostImage();
  
  Future<Either<String, void>> uploadPostImage();
  
}