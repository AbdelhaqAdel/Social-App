
class PostModel{
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? postText;
  String? postDate;

  PostModel(this.name,this.uId,this.image,this.postImage,this.postText,this.postDate);
  PostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uId=json['uid'];
    image=json['image'];
    postImage=json['postImage'];
    postText=json['postText'];
    postDate=json['postDate'];
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

