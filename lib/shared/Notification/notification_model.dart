class NotificationModel {
  String title;
  String body;
  String? image;
  NotificationModel({required this.title, required this.body,this.image});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
       if (image != '')'image': image
    };  
  }
}