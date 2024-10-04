import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendPushNotification(String title) async {
  const String serverKey = 'YOUR_SERVER_KEY_HERE'; // Replace with your server key
  const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  // Build the notification body with dynamic title
  final Map<String, dynamic> notificationPayload = {
    "message": {
      "topic": "all",  // You can replace this with a specific token if needed
      "notification": {
        "title": title, // Use the dynamic title here
        "body": "Testing body",
        "image": "https://th.bing.com/th?id=OIP.IGNf7GuQaCqz_RPq5wCkPgHaLH&w=204&h=306&c=8&rs=1&qlt=90&o=6&dpr=1.9&pid=3.1&rm=2"
      }
    }
  };

  // Send the HTTP POST request
  final response = await http.post(
    Uri.parse(fcmUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    },
    body: jsonEncode(notificationPayload),
  );

  // Check the response
  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}
