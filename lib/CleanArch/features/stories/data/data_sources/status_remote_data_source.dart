import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';

abstract class StatusRemoteDataSource {
  Stream<List<Map<String,dynamic>>>getAllUsersAddedStatus();
  Stream<List<StatusModel>> getUserStatus({required String userId});
  Future<void> addUserStatus({required String statusText,required Color statusColor});
}

class StatusRemoteDataSourceImpl implements StatusRemoteDataSource {

  @override
  Stream<List<Map<String,dynamic>>> getAllUsersAddedStatus() {
    List<Map<String,dynamic>>allUsersData=[];
     return FirebaseFirestore.instance.collection('status').snapshots().map((doc) {
        for(var element in doc.docs){
          allUsersData.add(element.data());
        }
        return allUsersData;
      });
    }

  @override
  Stream<List<StatusModel>> getUserStatus({required String userId}) {
    return FirebaseFirestore.instance
.collection('status').doc(userId).collection('allStatus')
    .snapshots()
        .map((snapshot) {
          print('userrr status ${snapshot.docs.length}');
          return snapshot.docs
              .map((doc) => StatusModel.fromJson(doc.data()))
              .toList();
        });
  }
  
  @override
  Future<void> addUserStatus({required String statusText,required Color statusColor})async {

      final status = StatusModel(
      name: userModel?.name,
      uId: userModel?.uId,
      userImage: userModel?.image,
      statusImage: '',
      statusText: statusText,
      statusDate: DateTime.now().toString(),
      statusColor: statusColor.value,
    );
         var newStatus=FirebaseFirestore.instance.collection('status').doc(uid);
         FirebaseFirestore.instance.collection('status').doc(uid).collection('allStatus').get().then((value){
           value.docs.length;
         });
        int statusNum=await addStatusNumber(newStatus)+1;
    final Map<String,dynamic> userData = {
      'name':userModel?.name,
      'image':userModel?.image,
      'date':DateTime.now().toString(),
      'uId':userModel?.uId,
      'statusNumber':statusNum
    };
      await newStatus.collection('allStatus').add(status.toMap());
          newStatus.set(userData);
  }
  Future<int> addStatusNumber(newStatus)async{
     int? statusNumber;
  await newStatus.collection('allStatus').get().then((value){
       statusNumber= value.docs.length;
           print('status number---------------------------- $statusNumber');
         });
   return statusNumber!;
  }


}
