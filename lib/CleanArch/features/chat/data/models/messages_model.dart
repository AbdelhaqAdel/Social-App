class MessagesModel{
  final String message;
  final String receiver;
  String date;
  MessagesModel(this.message,this.receiver,this.date,);

   factory MessagesModel.fromJson(jsonData){
    return MessagesModel(
        jsonData['message'],jsonData['id'],jsonData['date']);
  }
  Map<String,dynamic> toMap(){
    return{
    'message':message,
      'id':receiver,
      'date':date
    };
  }
}