
class PostModel{
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? postText;
  String? postDate;
  int?postLikes;
  bool?isUserLike;

  PostModel({this.name,this.uId,this.image,this.postImage,this.postText,this.postDate,this.postLikes,required this.isUserLike});
  factory PostModel.fromJson(Map<String,dynamic>json){
    return PostModel(
    name:     json['name'],
    uId:      json['uid'],
    image:    json['image'],
    postImage:json['postImage'],
    postText: json['postText'],
    postDate: json['postDate'],
    postLikes:json['likes'],
    isUserLike:json['isUserLike'],
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
    };
  }
}

