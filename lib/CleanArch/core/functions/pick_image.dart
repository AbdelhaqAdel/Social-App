  import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
class AppFunctions{
 static Future<Either<String, XFile>> pickImage()async{
    try{
    final ImagePicker imagePicker =ImagePicker();
    XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
    if(file!=null){
    return right(file);
    }
    return left('image not picked');
    }catch (e){
      return left(e.toString());
    }
  }}