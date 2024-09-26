import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';
import 'package:newapp/CleanArch/features/stories/domain/use_cases/add_user_status_use_case.dart';
import 'package:newapp/CleanArch/features/stories/domain/use_cases/get_all_status_use_case.dart';

part 'story_state.dart';

class StatusCubit extends Cubit<StatusState> {
static StatusCubit get(context)=>BlocProvider.of(context);   

 final GetAllStatusUseCase getAllStatusUseCase;
 final AddUserStatusUseCase addUserStatusUseCase;
  StatusCubit({required this.getAllStatusUseCase,required this.addUserStatusUseCase}) : super(StatusInitial());


List<StatusModel> status=[];
  void fetchStatuses() {
    emit(GetAllStatusLoadingState());
    final result=getAllStatusUseCase.call();
    result.fold(
      (l) => emit(GetAllStatusErrorState(l.message)),
      (allStatus){
        allStatus.listen((status) {
          this.status=status;
         emit(GetAllStatusSuccessState(status));
        });
      }
      );
  }
  
  void addUserStatus({required String statusText})async{
    emit(AddStatusLoadingLoadingState());
   final result=await addUserStatusUseCase.call(statusText);  
   result.fold((l) =>emit(AddStatusErrorState(l.message)),
    (r) =>emit(AddStatusSuccessState()) );
  }

  //   Uint8List? pickStatusImage;
  // String? stringStatusImage;
  // PickStatusImage()async{
  //   final ImagePicker imagePicker =ImagePicker();
  //   XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
  //   if(file!=null){
  //     stringStatusImage=file.path;
  //     pickStatusImage=await file.readAsBytes();
  //     emit(ImageStatusPickedSuccessState());
  //   }
  //   else{
  //     print('no image selected');
  //     emit(ImageStatusPickedErrorState());

  //   }
  // }

  // String? statusImage;
  // void uploadStatusImage(){
  //   firebase_storage.FirebaseStorage
  //       .instance
  //       .ref()
  //       .child('status/${Uri.file(stringStatusImage!)
  //       .pathSegments.last}')
  //       .putFile(File(stringStatusImage!)).then((value){
  //     value.ref.getDownloadURL().then((value) {
  //       statusImage=value;
  //       emit(CreateStatusSuccessState());
  //       // print('the picked image : ${value}');
  //     }).catchError((error){
  //       print('Errorrr ${Error}');
  //       emit(CreateStatusErrorState());
  //     });
  //   }).catchError((error){
  //     emit(CreateStatusErrorState());
  //     print('Puting file Error ${error}');
  //   });
  // }



  // void addUserStatus({
  //   String? statusText,
  // }){
  //   StatusModel model=StatusModel(
  //   name:userModel?.name,
  //   uId: userModel?.uId,
  //   image: userModel?.image,
  //   postImage: '',
  //   postText: statusText,
  //   postDate: DateTime.now().toString(),
  //   );
  //   FirebaseFirestore.instance.collection('status')
  //       .add(model.toMap());
  // }



//   List<StatusModel>allUserAddStatus=[];
//   void whoUserAddStory()async {
//     emit(GetUserAddStatusLoadingState());

//     await FirebaseFirestore.instance.collection(kUsers).get().then((value){
//       value.docs.forEach((element) {
//         element.reference.collection('status').get().then((value) {
//           value.docs.forEach((element) {
//             if(DateTime.parse(element.get('postDate')).hour<=DateTime.now().hour
//                 &&DateTime.parse(element.get('postDate')).day!=DateTime.now().day
//             ){
//               element.reference.delete();
//               print('cleared::${DateTime.now().hour+1}');
//               print(DateTime.parse(element.get('postDate')).hour);
//             }
//             else{
//               print('sss');
//             }
//           });
//           //  print(value.docs.isEmpty);
//           if(value.docs.isNotEmpty){
//             allUserAddStatus.add(StatusModel.fromJson(element.data()));
//           }
//           emit(GetUserAddStatusSuccessState(status: allUserAddStatus));
//         });
//       });
//       // print('lllll${allUserAddStatus.length}');
//     }).catchError((error){
//       print('getting all ststus user error ${error}');
//       emit(GetUserAddStatusErrorState());

//     });

//   }

// //Stream of status updates
//   Stream< List<StatusModel>> getAllStatus() {
//     return FirebaseFirestore.instance
//         .collection(kUsers)
//         .doc(uid)
//         .collection('status')
//         .orderBy('postDate', descending: true)
//         .snapshots()    .map((snapshot) {
//         return snapshot.docs
//             .map((doc) => StatusModel.fromJson(doc.data()))
//             .toList();
//       });
//   }


//  List<StatusModel> allStatus=[];
//   void getStatusData(String? userId)async
//   {
//     emit(GetStatusLoadingState());

//     await  FirebaseFirestore.instance.collection(kUsers).doc(userId).collection('status')
//         .get().then((value) {

//       value.docs.forEach((element) {
//        allStatus.add(StatusModel.fromJson(element.data()));

//       });
//       emit(GetStatusSuccessState());

//     }).catchError((error){
//       print('error from get status : ${error}');
//       emit(GetStatusErrorState());

//     });
//   }


}
