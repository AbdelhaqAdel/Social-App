class SignInModel {
  final String uid;

SignInModel({required this.uid});

factory SignInModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInModel(
      uid: jsonData['uid'],
    );
  }
}
