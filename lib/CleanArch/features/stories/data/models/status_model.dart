class StatusModel{
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? postText;
  String? postDate;

  StatusModel({this.name,this.uId,this.image,this.postImage,this.postText,this.postDate,});
  factory StatusModel.fromJson(Map<String,dynamic>json){
   return StatusModel(  
    name:json['name'],
    uId:json['uid'],
    image:json['image'],
    postImage:json['postImage'],
    postText:json['postText'],
    postDate:json['postDate'],
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
    };
  }
}