class StatusModel{
  String? name;
  String? uId;
  String? userImage;
  String? statusImage;
  String? statusText;
  String? statusDate;
  int? statusColor;

  StatusModel({this.name,this.uId,this.userImage,this.statusImage,this.statusText,this.statusDate,this.statusColor});
  factory StatusModel.fromJson(Map<String,dynamic>json){
   return StatusModel(  
    name:json['name'],
    uId:json['uid'],
    userImage:json['userImage'],
    statusImage:json['statusImage'],
    statusText:json['statusText'],
    statusDate:json['statusDate'],
    statusColor:json['statusColor'],
   );
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uid':uId,
      'userImage':userImage,
      'statusImage':statusImage,
      'statusText':statusText,
      'statusDate':statusDate,
      'statusColor':statusColor,
    };
  }
}