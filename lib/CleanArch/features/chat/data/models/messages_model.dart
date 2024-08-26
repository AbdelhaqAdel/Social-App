class MessagesModel{
  final String message;
  final String reciever;
  String date;
  MessagesModel(this.message,this.reciever,this.date,);

   factory MessagesModel.fromJson(jsonData){
    return MessagesModel(
        jsonData['message'],jsonData['id'],jsonData['date']);
  }
  Map<String,dynamic> toMap(){
    return{
    'message':message,
      'id':reciever,
      'date':date
    };
  }
}