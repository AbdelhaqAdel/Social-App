class UserModel{
  String? name;
  String? email;
  String uId;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? nickname;
  UserModel({this.name,this.email,required this.uId,this.phone,this.image,this.bio,this.cover,this.nickname});

  factory UserModel.fromJson(Map<String,dynamic>json){return 
  UserModel(
    name:json['name'],
    email:json['email'],
    uId:json['uid'],
    phone:json['phone']??'',
    image:json['image']??'',
    bio:json['bio']??'',
    cover:json['cover']??'',
    nickname:json['nickname']??'');
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
    };
  }
}