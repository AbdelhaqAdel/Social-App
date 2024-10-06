
class PostModel{
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? postText;
  String? postDate;
  int?postLikes;
  int?postComments;
  String? fcmToken;

  bool?isUserLike;

  PostModel({this.name,this.uId,this.image,this.postImage,this.postText,this.postDate,this.postLikes,this.postComments,required this.isUserLike,
  required this.fcmToken
  });
  factory PostModel.fromJson(Map<String,dynamic>json){
    return PostModel(
    name:     json['name'],
    uId:      json['uid'],
    image:    json['image'],
    postImage:json['postImage'],
    postText: json['postText'],
    postDate: json['postDate'],
    postLikes:json['likes'],
    postComments:json['comments'],
    isUserLike:json['isUserLike'],
    fcmToken:json['fcm']
    );
  }


  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uid':uId,
      'image':image,
      'postImage':postImage,
      'postText':postText,
      'postDate':postDate,
      'likes':postLikes,
      'isUserLike':isUserLike,
      'comments':postComments,
      'fcm':fcmToken
    };
  }
}

