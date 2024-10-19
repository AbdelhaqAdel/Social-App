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
Stream<List<Map<String, dynamic>>> getAllUsersAddedStatus() {
  return FirebaseFirestore.instance.collection('status').snapshots().map((snapshot) {
    List<Map<String, dynamic>> allUsersData = [];
    for (var element in snapshot.docs) {
      if(element.data()['statusNumber']!=0){
      allUsersData.add(element.data());}
    }
    return allUsersData.isNotEmpty ? allUsersData : [];
  });
}
 
@override
Stream<List<StatusModel>> getUserStatus({required String userId}) {
   var newStatus= FirebaseFirestore.instance.collection('status').doc(uid);

  return FirebaseFirestore.instance
      .collection('status')
      .doc(userId)
      .collection('allStatus')
      .snapshots()
      .asyncMap((snapshot) async {
        final now = DateTime.now();
        final List<StatusModel> statuses = [];

        for (var doc in snapshot.docs) {
          final status = StatusModel.fromJson(doc.data());
          final createdAt = DateTime.parse(status.statusDate!);

          if (now.difference(createdAt).inHours < 24) {
            statuses.add(status);
          } else {
            await FirebaseFirestore.instance
                .collection('status')
                .doc(userId)
                .collection('allStatus')
                .doc(doc.id)
                .delete();
          newStatus.set(setUserStatus(statusNum:await addStatusNumber(newStatus)));
          }
        }
        return statuses;
      });
}


  @override
  Future<void> addUserStatus({required String statusText,required Color statusColor})async {
 var newStatus= FirebaseFirestore.instance.collection('status').doc(uid);

      final status = StatusModel(
      name: userModel?.name,
      uId: uid,
      userImage: userModel?.image,
      statusImage: '',
      statusText: statusText,
      statusDate: DateTime.now().toString(),
      statusColor: statusColor.value,
    );
        
      await newStatus.collection('allStatus').add(status.toMap());

      newStatus.set( setUserStatus(statusNum:await addStatusNumber(newStatus)));
  }
  
  Future<int> addStatusNumber(newStatus)async{
     int? statusNumber;
  await newStatus.collection('allStatus').get().then((value){
       statusNumber= value.docs.length;
         });
   return statusNumber!;
  }

Map<String,dynamic> setUserStatus({required int statusNum}) {
     final Map<String,dynamic> userData = {
      'name':userModel?.name,
      'image':userModel?.image,
      'date':DateTime.now().toString(),
      'uId':uid,
      'statusNumber':statusNum
    };
    return userData;
}

}