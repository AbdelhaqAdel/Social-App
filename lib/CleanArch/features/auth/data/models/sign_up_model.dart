import 'package:hive/hive.dart';
part 'sign_up_model.g.dart';

@HiveType(typeId: 0)
class RegisterModel{
  @HiveField(0)  
 final String? name;

  @HiveField(1)
 final String? email;

  @HiveField(2)
 final String uId;

  @HiveField(3)
 final String? phone;

  @HiveField(4)
 final String? image;

  @HiveField(5)
 final String? cover;

  @HiveField(6)
 final String? bio;

  @HiveField(7) 
 final String? nickname;

 @HiveField(8)
 final String? fcmToken;

  RegisterModel({required this.name,required this.email,required this.uId,
 required this.phone,this.image,this.bio,this.cover,this.nickname,required this.fcmToken,});

  factory RegisterModel.fromJson({required Map<String,dynamic>? json}){
    return RegisterModel(
    name:json?['name']??'',
    email:json?['email']??'',
    uId:json?['uid']??"",
    phone:json?['phone']??'',
    image:json?['image']??'',
    bio:json?['bio']??'',
    cover:json?['cover']??'',
    nickname:json?['nickname']??'',
    fcmToken: json?['fcm']??''
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