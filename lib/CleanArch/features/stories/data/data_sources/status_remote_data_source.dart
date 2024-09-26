import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';

abstract class StatusRemoteDataSource {
  Stream<List<StatusModel>> getAllStatus();
  Future<void> addUserStatus({required String statusText});
}

class StatusRemoteDataSourceImpl implements StatusRemoteDataSource {
  @override
  Stream<List<StatusModel>> getAllStatus() {
    return FirebaseFirestore.instance.
    collection('status').orderBy('postDate')
    .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => StatusModel.fromJson(doc.data()))
              .toList();
        });

        // .collection(kUsers)
        // .doc(uid)
        // .collection('status')
        // .orderBy('postDate', descending: true)
        // .snapshots()
        // .map((snapshot) {
        //   return snapshot.docs
        //       .map((doc) => StatusModel.fromJson(doc.data()))
        //       .toList();
        // });
  }
  
  @override
  Future<void> addUserStatus({required String statusText})async {
      final status = StatusModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      postImage: '',
      postText: statusText,
      postDate: DateTime.now().toString(),
    );
      await FirebaseFirestore.instance.collection('status')
      .add(status.toMap());
  }

}
