class UserRegisterModel{
  String? name;
  String? email;
  String? uId;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? nickname;
  UserRegisterModel(this.name,this.email,this.uId,this.phone,this.image,this.bio,this.cover,this.nickname);
  UserRegisterModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uId=json['uid'];
    phone=json['phone']??'';
    image=json['image']??'';
    bio=json['bio']??'';
    cover=json['cover']??'';
    nickname=json['nickname']??'';
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