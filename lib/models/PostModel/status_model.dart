class StatusModel{
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? postText;
  String? postDate;
  //Color? color;
  //int?id;
  StatusModel(this.name,this.uId,this.image,this.postImage,this.postText,
      this.postDate,
      //this.color
      );
  StatusModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uId=json['uid'];
    image=json['image'];
    postImage=json['postImage'];
    postText=json['postText'];
    postDate=json['postDate'];
   // color=json['color'];
   // id=json['id'];
  }


  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uid':uId,
      'image':image,
      'postImage':postImage,
      'postText':postText,
      'postDate':postDate,
     // 'color':color,
    //  'id':id,
    };
  }
}