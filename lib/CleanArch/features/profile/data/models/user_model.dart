class UserModel{
 final String? name;
 final String? email;
 final String uId;
 final String? phone;
 final String? image;
 final String? cover;
 final String? bio;
 final String? nickname;
 final String? fcmToken;
  UserModel({required this.name,required this.email,required this.uId,
 required this.phone,this.image,this.bio,this.cover,this.nickname,required this.fcmToken});

  factory UserModel.fromJson({required Map<String,dynamic>? json}){
    return UserModel(
    name:json?['name']??'',
    email:json?['email']??'',
    uId:json?['uid']??"",
    phone:json?['phone']??'',
    image:json?['image']??'',
    bio:json?['bio']??'',
    cover:json?['cover']??'',
    nickname:json?['nickname']??'',
    fcmToken: json?['fcm'] ?? '',
    );
  }


  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'uid':uId,
      'phone':phone,
      'image':image,
      'bio':bio,
      'cover':cover,
      'nickname':nickname,
      'fcm':fcmToken  
    };
  }
}